import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/models/client.dart';
import 'package:hader_pharm_mobile/models/deligate_order.dart';
import 'package:hader_pharm_mobile/models/para_pharm_filters.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/para_pharma_catalog_repository.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/params/params_load_parapharma.dart';
import 'package:hader_pharm_mobile/utils/debounce.dart';

part 'edit_order_state.dart';

class DeligateEditOrderCubit extends Cubit<DeligateEditOrderState> {
  final IParaPharmaRepository parapharmaRepo;
  final IOrderRepository orderRepo;

  DebounceManager debounceManager = DebounceManager();

  DeligateEditOrderCubit({
    required this.parapharmaRepo,
    required this.orderRepo,
    required TextEditingController packageQuantityController,
    required ScrollController scrollController,
    required TextEditingController searchController,
    required TextEditingController quantityController,
    required TextEditingController customPriceController,
  }) : super(DeligateOrderInitial(
          client: DelegateClient.empty(),
          scrollController: scrollController,
          searchController: searchController,
          quantityController: quantityController,
          packageQuantityController: packageQuantityController,
          customPriceController: customPriceController,
        ));

  void searchProducts([String? text]) => debounceManager.debounce(tag: "search", action: () => getProducts());

  Future<void> getProducts({int offset = 0}) async {
    try {
      final searchText = state.searchController.text.trim();

      emit(state.toLoading(offset: offset));

      final response = await parapharmaRepo.getParaPharmaCatalog(
        ParamsLoadParapharma(
          limit: state.limit,
          offset: state.offSet,
          filters: ParaPharmFilters(
              // name: searchText.isNotEmpty ? [searchText] : [],
              ),
          includeFavorites: false,
        ),
      );

      emit(state.toLoaded(
        products: response.data,
        totalItemsCount: response.totalItems,
        hasReachedMax: response.data.length >= response.totalItems,
      ));
    } catch (e) {
      debugPrint("Error loading clients: $e");
      emit(state.toFailed(
        "Failed to load clients",
      ));
    }
  }

  Future<void> refreshProducts() async {
    await getProducts();

    emit(state.toInitial());
  }

  @override
  Future<void> close() {
    debounceManager.cancel("search");
    return super.close();
  }

  void incrementQuantity() {
    final updatedQuantity = state.quantity + 1;

    state.quantityController.text = updatedQuantity.toString();
    state.packageQuantityController.text = (updatedQuantity ~/ (state.selectedProduct?.packageSize ?? 1)).toString();

    final newState = state.toUpdateSuggestedPrice(
        quantity: updatedQuantity,
        totalPrice: ((double.tryParse(state.customPriceController.text) ?? 0) * updatedQuantity));
    emit(newState);
  }

  void decrementQuantity() {
    final updatedQuantity = state.quantity > 1 ? state.quantity - 1 : 1;

    state.quantityController.text = updatedQuantity.toString();
    state.packageQuantityController.text = (updatedQuantity ~/ (state.selectedProduct?.packageSize ?? 1)).toString();

    emit(state.toUpdateSuggestedPrice(
        quantity: updatedQuantity,
        totalPrice: ((double.tryParse(state.customPriceController.text) ?? 0) * updatedQuantity)));
  }

  void decrementItemQuantity({
    required DeligateParahparmOrderItemUi item,
  }) {
    final tempQuantity = int.parse(item.quantityController.text);
    final updatedQuantity = tempQuantity > 1 ? tempQuantity - 1 : 1;

    item.quantityController.text = updatedQuantity.toString();

    item.packageQuantityController.text = (updatedQuantity ~/ (item.model.product.packageSize)).toString();

    final updatedItem = item.copyWith(model: item.model.copyWith(quantity: updatedQuantity));

    emit(
      state.toProductsUpdated(
        item: updatedItem,
      ),
    );
  }

  void incrementItemQuantity({
    required DeligateParahparmOrderItemUi item,
  }) {
    final updatedQuantity = item.model.quantity + 1;

    item.quantityController.text = updatedQuantity.toString();

    item.packageQuantityController.text = (updatedQuantity ~/ (item.model.product.packageSize)).toString();

    final updatedItem = item.copyWith(model: item.model.copyWith(quantity: updatedQuantity));

    emit(
      state.toProductsUpdated(
        item: updatedItem,
      ),
    );
  }

  void selectProduct(BaseParaPharmaCatalogModel product) {
    state.customPriceController.text = product.unitPriceHt.toString();

    emit(state.toUpdateSelectedProduct(product: product));
  }

  void updateCustomPrice(String? price) {
    final priceValue = state.selectedProduct?.unitPriceHt;

    emit(state.toUpdateSuggestedPrice(price: priceValue, totalPrice: (priceValue ?? 0) * state.quantity));
  }

  void updateItemCustomPrice(String? value, DeligateParahparmOrderItemUi item) => debounceManager.debounce(
      tag: "price",
      duration: const Duration(milliseconds: 1000),
      action: () async {
        final priceValue = double.tryParse(value ?? '0');

        final updatedItem = item.copyWith(model: item.model.copyWith(suggestedPrice: priceValue));

        emit(state.toProductsUpdated(item: updatedItem));
      });

  void decrementPackageQuantity() {
    final currPackageQuantity = int.parse(state.packageQuantityController.text) - 1;

    final updatedItemQuantity = (currPackageQuantity * (state.selectedProduct?.packageSize ?? 1));

    state.packageQuantityController.text = (currPackageQuantity < 1 ? 1 : currPackageQuantity).toString();

    state.quantityController.text = (updatedItemQuantity < 1 ? 1 : updatedItemQuantity).toString();
    emit(state.toUpdateSuggestedPrice(quantity: updatedItemQuantity));
  }

  void incrementPackageQuantity() {
    final currPackageQuantity = int.parse(state.packageQuantityController.text) + 1;

    final updatedItemQuantity = (currPackageQuantity * (state.selectedProduct?.packageSize ?? 1));

    state.packageQuantityController.text = currPackageQuantity.toString();

    state.quantityController.text = updatedItemQuantity.toString();
    emit(state.toUpdateSuggestedPrice(quantity: updatedItemQuantity));
  }

  void updateQuantityPackage(String quantity) {
    final currPackageQuantity = int.parse(quantity);

    final updatedItemQuantity = (currPackageQuantity * (state.selectedProduct?.packageSize ?? 1));
    state.packageQuantityController.text = currPackageQuantity.toString();

    state.quantityController.text = updatedItemQuantity.toString();
    emit(state.toUpdateSuggestedPrice(quantity: updatedItemQuantity));
  }

  void updateQuantity(String quantity) {
    final updatedQuantity = int.parse(quantity);

    state.quantityController.text = updatedQuantity.toString();

    state.packageQuantityController.text = (updatedQuantity ~/ (state.selectedProduct?.packageSize ?? 1)).toString();

    emit(state.toUpdateSuggestedPrice(
        quantity: updatedQuantity,
        totalPrice: ((double.tryParse(state.customPriceController.text) ?? 0) * updatedQuantity)));
  }

  void resetSelectedProduct() {
    emit(state.toResetSelectedProduct());
  }
}
