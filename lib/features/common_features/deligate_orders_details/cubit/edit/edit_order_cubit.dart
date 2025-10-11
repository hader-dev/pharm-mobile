import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/models/client.dart';
import 'package:hader_pharm_mobile/models/deligate_order.dart';
import 'package:hader_pharm_mobile/models/para_medical_filters.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/para_pharma_catalog_repository.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/params/params_load_parapharma.dart';
import 'package:hader_pharm_mobile/utils/debounce.dart';

part 'edit_order_state.dart';

class DeligateEditOrderCubit extends Cubit<DeligateEditOrderState> {
  final IParaPharmaRepository parapharmaRepo;
  final IOrderRepository orderRepo;
  final ScrollController scrollController;
  final TextEditingController searchController;
  final TextEditingController customPriceController;
  final TextEditingController quantityController;
  final TextEditingController packageQuantityController;

  DebouncerManager debounceManager = DebouncerManager();

  DeligateEditOrderCubit({
    required this.parapharmaRepo,
    required this.orderRepo,
    required this.packageQuantityController,
    required this.scrollController,
    required this.searchController,
    required this.quantityController,
    required this.customPriceController,
  }) : super(DeligateOrderInitial(client: DeligateClient.empty()));

  void searchProducts([String? text]) =>
      debounceManager.debounce(tag: "search", action: () => getProducts());

  Future<void> getProducts({int offset = 0}) async {
    try {
      final searchText = searchController.text.trim();

      emit(state.loading(offset: offset));

      final response = await parapharmaRepo.getParaPharmaCatalog(
        ParamsLoadParapharma(
          limit: state.limit,
          offset: state.offSet,
          filters: ParaMedicalFilters(
            name: searchText.isNotEmpty ? [searchText] : [],
          ),
          includeFavorites: false,
        ),
      );

      emit(state.loaded(
        products: response.data,
        totalItemsCount: response.totalItems,
        hasReachedMax: response.data.length >= response.totalItems,
      ));
    } catch (e) {
      debugPrint("Error loading clients: $e");
      emit(state.failed(
        "Failed to load clients",
      ));
    }
  }

  Future<void> refreshProducts() async {
    emit(state.initial());
    await getProducts();
  }

  @override
  Future<void> close() {
    debounceManager.cancel("search");
    return super.close();
  }

  void incrementQuantity() {
    final updatedQuantity = state.quantity + 1;

    quantityController.text = updatedQuantity.toString();

    final newState = state.updateSuggestedPrice(
        quantity: updatedQuantity,
        totalPrice: ((double.tryParse(customPriceController.text) ?? 0) *
            updatedQuantity));
    emit(newState);
  }

  void decrementQuantity() {
    final updatedQuantity = state.quantity > 1 ? state.quantity - 1 : 1;

    quantityController.text = updatedQuantity.toString();

    emit(state.updateSuggestedPrice(
        quantity: updatedQuantity,
        totalPrice: ((double.tryParse(customPriceController.text) ?? 0) *
            updatedQuantity)));
  }

  void decrementItemQuantity({
    required DeligateParahparmOrderItemUi item,
  }) {
    final tempQuantity = int.parse(item.quantityController.text);
    final updatedQuantity = tempQuantity > 1 ? tempQuantity - 1 : 1;

    item.quantityController.text = updatedQuantity.toString();

    item.packageQuantityController.text =
        (updatedQuantity ~/ (item.model.product.packageSize)).toString();

    final updatedItem =
        item.copyWith(model: item.model.copyWith(quantity: updatedQuantity));

    emit(
      state.productsUpdated(
        item: updatedItem,
      ),
    );
  }

  void incrementItemQuantity({
    required DeligateParahparmOrderItemUi item,
  }) {
    final updatedQuantity = item.model.quantity + 1;

    item.quantityController.text = updatedQuantity.toString();

    item.packageQuantityController.text =
        (updatedQuantity ~/ (item.model.product.packageSize)).toString();

    final updatedItem =
        item.copyWith(model: item.model.copyWith(quantity: updatedQuantity));

    emit(
      state.productsUpdated(
        item: updatedItem,
      ),
    );
  }

  void selectProduct(BaseParaPharmaCatalogModel product) {
    emit(state.updateSelectedProduct(product: product));
    customPriceController.text = product.unitPriceHt;
  }

  void updateCustomPrice(String? price) {
    final priceValue =
        double.tryParse(price ?? (state.selectedProduct?.unitPriceHt ?? '0'));

    emit(state.updateSuggestedPrice(
        price: priceValue, totalPrice: (priceValue ?? 0) * state.quantity));
  }

  void updateItemCustomPrice(
          String? value, DeligateParahparmOrderItemUi item) =>
      debounceManager.debounce(
          tag: "price",
          duration: const Duration(milliseconds: 1000),
          action: () async {
            final priceValue = double.tryParse(value ?? '0');

            final updatedItem = item.copyWith(
                model: item.model.copyWith(suggestedPrice: priceValue));

            emit(state.productsUpdated(item: updatedItem));
          });

  void decrementPackageQuantity() {
    final currPackageQuantity = int.parse(packageQuantityController.text) - 1;

    final updatedItemQuantity =
        (currPackageQuantity * (state.selectedProduct?.packageSize ?? 1));

    packageQuantityController.text =
        (currPackageQuantity < 1 ? 1 : currPackageQuantity).toString();

    quantityController.text =
        (updatedItemQuantity < 1 ? 1 : updatedItemQuantity).toString();
    emit(state.updateSuggestedPrice(quantity: updatedItemQuantity));
  }

  void incrementPackageQuantity() {
    final currPackageQuantity = int.parse(packageQuantityController.text) + 1;

    final updatedItemQuantity =
        (currPackageQuantity * (state.selectedProduct?.packageSize ?? 1));

    packageQuantityController.text = currPackageQuantity.toString();

    quantityController.text = updatedItemQuantity.toString();
    emit(state.updateSuggestedPrice(quantity: updatedItemQuantity));
  }

  void updateQuantityPackage(String quantity) {
    final currPackageQuantity = int.parse(quantity);

    final updatedItemQuantity =
        (currPackageQuantity * (state.selectedProduct?.packageSize ?? 1));
    packageQuantityController.text = currPackageQuantity.toString();

    quantityController.text = updatedItemQuantity.toString();
    emit(state.updateSuggestedPrice(quantity: updatedItemQuantity));
  }

  void updateQuantity(String quantity) {
    final updatedQuantity = int.parse(quantity);

    quantityController.text = updatedQuantity.toString();

    packageQuantityController.text =
        (updatedQuantity ~/ (state.selectedProduct?.packageSize ?? 1))
            .toString();

    emit(state.updateSuggestedPrice(
        quantity: updatedQuantity,
        totalPrice: ((double.tryParse(customPriceController.text) ?? 0) *
            updatedQuantity)));
  }
}
