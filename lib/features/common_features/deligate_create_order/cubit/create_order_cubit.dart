import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/models/client.dart';
import 'package:hader_pharm_mobile/models/deligate_order.dart';
import 'package:hader_pharm_mobile/models/para_medical_filters.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/create_deligate_order.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/para_pharma_catalog_repository.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/params/params_load_parapharma.dart';
import 'package:hader_pharm_mobile/utils/debounce.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';

part 'create_order_state.dart';

class DeligateCreateOrderCubit extends Cubit<DeligateCreateOrderState> {
  final IParaPharmaRepository parapharmaRepo;
  final IOrderRepository orderRepo;
  final ScrollController scrollController;
  final TextEditingController searchController;
  final TextEditingController customPriceController;
  final TextEditingController quantityController;
  final TextEditingController packageQuantityController;

  DebouncerManager debounceManager = DebouncerManager();

  DeligateCreateOrderCubit({
    required this.parapharmaRepo,
    required this.orderRepo,
    required this.scrollController,
    required this.packageQuantityController,
    required this.searchController,
    required this.quantityController,
    required this.customPriceController,
  }) : super(DeligateOrderInitial(client: DeligateClient.empty())) {
    _onScroll();
  }

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

  Future<void> loadMoreClients() async {
    try {
      if (state.offSet >= state.totalItemsCount) {
        emit(state.limitReached());
        return;
      }

      final offSet = state.offSet + state.limit;
      emit(state.loading(offset: offSet));

      final response =
          await parapharmaRepo.getParaPharmaCatalog(ParamsLoadParapharma(
        limit: state.limit,
        offset: offSet,
        includeFavorites: false,
      ));

      emit(state.loaded(
        products: response.data,
        totalItemsCount: response.totalItems,
        hasReachedMax: response.data.length >= response.totalItems,
      ));
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      debugPrint("Error loading more announcements: $e");
      emit(state.failed(
        "Failed to load more announcements",
      ));
    }
  }

  Future<void> refreshProducts() async {
    emit(state.initial());
    await getProducts();
  }

  _onScroll() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (state.offSet < state.totalItemsCount) {
          await loadMoreClients();
        } else {
          emit(state.limitReached());
        }
      }
    });
  }

  @override
  Future<void> close() {
    debounceManager.cancel("search");
    return super.close();
  }

  void incrementQuantity() {
    final updatedQuantity = state.quantity + 1;

    quantityController.text = updatedQuantity.toString();

    packageQuantityController.text =
        (updatedQuantity ~/ (state.selectedProduct?.packageSize ?? 1))
            .toString();

    final newState = state.updateSuggestedPrice(
        quantity: updatedQuantity,
        totalPrice: ((double.tryParse(customPriceController.text) ?? 0) *
            updatedQuantity));
    emit(newState);
  }

  void decrementQuantity() {
    final updatedQuantity = state.quantity > 1 ? state.quantity - 1 : 1;

    quantityController.text = updatedQuantity.toString();

    packageQuantityController.text =
        (updatedQuantity ~/ (state.selectedProduct?.packageSize ?? 1))
            .toString();

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

    item.packageQuantityController.text =
        (updatedQuantity ~/ (item.model.product.packageSize)).toString();

    item.quantityController.text = updatedQuantity.toString();

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
    final tempQuantity = int.parse(item.quantityController.text);

    final updatedQuantity = tempQuantity + 1;

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

  void addOrderItem() {
    if (state.selectedProduct == null) return;
    final translation =
        AppLayout.appLayoutScaffoldKey.currentContext!.translation!;
    final quantity = state.quantity;
    final customPrice = double.tryParse(customPriceController.text);

    emit(
      state.productsUpdated(
        item: DeligateParahparmOrderItemUi(
            quantityController:
                TextEditingController(text: quantityController.text),
            customPriceController:
                TextEditingController(text: customPriceController.text),
            packageQuantityController:
                TextEditingController(text: packageQuantityController.text),
            model: DeligateParahparmOrderItem(
                isParapharm: true,
                product: state.selectedProduct!,
                quantity: quantity,
                suggestedPrice: customPrice)),
      ),
    );

    getItInstance.get<ToastManager>().showToast(
          message: translation.order_placed_successfully,
          type: ToastType.success,
        );
  }

  void removeOrderItem(DeligateParahparmOrderItemUi item) {
    emit(
      state.productsUpdated(
        item: item,
        removed: true,
      ),
    );
  }

  void updateClient(DeligateClient client) {
    emit(state.clientUpdated(client: client));
  }

  Future<void> submitOrder() async {
    final context = AppLayout.appLayoutScaffoldKey.currentContext!;
    final translation = context.translation!;
    final messanger = getItInstance.get<ToastManager>();

    if (state.orderProducts.isEmpty || state.client.id.isEmpty) {
      messanger.showToast(
          type: ToastType.error,
          message: translation.feedback_select_client_and_add_items);
      return;
    }

    try {
      final userManager = getItInstance<UserManager>();
      await orderRepo.createDeligateOrder(ParamsCreateDeligateOrder(
        deliveryAddress: userManager.currentUser.address,
        deliveryTownId: userManager.currentUser.townId,
        orderItems: state.orderProducts.map((el) => el.model).toList(),
        clientId: state.client.buyerCompany.managerUserId!,
        clientCompanyId: state.client.buyerCompany.id,
      ));
      messanger.showToast(
          type: ToastType.success,
          message: translation.order_placed_successfully);

      emit(state.initial());
    } catch (e) {
      messanger.showToast(
          type: ToastType.error, message: translation.order_placed_failed);
    }
  }

  void decrementPackageItemQuantity({
    required DeligateParahparmOrderItemUi item,
  }) {
    final currPackageQuantity =
        int.parse(item.packageQuantityController.text) - 1;

    final updatedItemQuantity =
        (currPackageQuantity * (item.model.product.packageSize));

    item.packageQuantityController.text =
        (currPackageQuantity < 1 ? 1 : currPackageQuantity).toString();

    item.quantityController.text =
        (updatedItemQuantity < 1 ? 1 : updatedItemQuantity).toString();

    final updatedItem = item.copyWith(
        model: item.model.copyWith(quantity: updatedItemQuantity));

    emit(
      state.productsUpdated(
        item: updatedItem,
      ),
    );
  }

  void incrementPackageItemQuantity({
    required DeligateParahparmOrderItemUi item,
  }) {
    final currPackageQuantity =
        int.parse(item.packageQuantityController.text) + 1;

    final updatedItemQuantity =
        (currPackageQuantity * (item.model.product.packageSize));

    item.packageQuantityController.text = currPackageQuantity.toString();

    item.quantityController.text = updatedItemQuantity.toString();

    final updatedItem = item.copyWith(
        model: item.model.copyWith(quantity: updatedItemQuantity));

    emit(
      state.productsUpdated(
        item: updatedItem,
      ),
    );
  }

  void decrementPackageQuantity() {
    final currPackageQuantity = int.parse(packageQuantityController.text) - 1;

    final updatedItemQuantity =
        (currPackageQuantity * (state.selectedProduct?.packageSize ?? 1));

    packageQuantityController.text =
        (currPackageQuantity < 1 ? 1 : currPackageQuantity).toString();

    quantityController.text =
        (updatedItemQuantity < 1 ? 1 : updatedItemQuantity).toString();
    emit(state.updateSuggestedPrice(
        quantity: updatedItemQuantity,
        totalPrice: ((double.tryParse(customPriceController.text) ?? 0) *
            updatedItemQuantity)));
  }

  void incrementPackageQuantity() {
    final currPackageQuantity = int.parse(packageQuantityController.text) + 1;

    final updatedItemQuantity =
        (currPackageQuantity * (state.selectedProduct?.packageSize ?? 1));

    packageQuantityController.text = currPackageQuantity.toString();

    quantityController.text = updatedItemQuantity.toString();
    emit(state.updateSuggestedPrice(
        quantity: updatedItemQuantity,
        totalPrice: ((double.tryParse(customPriceController.text) ?? 0) *
            updatedItemQuantity)));
  }

  void updateItemQuantity({
    required DeligateParahparmOrderItemUi item,
  }) {
    final updatedItemQuantity = int.parse(item.quantityController.text);

    item.packageQuantityController.text =
        (updatedItemQuantity ~/ item.model.product.packageSize).toString();

    item.quantityController.text = updatedItemQuantity.toString();

    final updatedItem = item.copyWith(
        model: item.model.copyWith(quantity: updatedItemQuantity));

    emit(
      state.productsUpdated(
        item: updatedItem,
      ),
    );
  }

  void updateItemPackageQuantity({
    required DeligateParahparmOrderItemUi item,
  }) {
    final currPackageQuantity = int.parse(item.packageQuantityController.text);

    final updatedItemQuantity =
        (currPackageQuantity * (item.model.product.packageSize));
    item.packageQuantityController.text = currPackageQuantity.toString();

    item.quantityController.text = updatedItemQuantity.toString();

    final updatedItem = item.copyWith(
        model: item.model.copyWith(quantity: updatedItemQuantity));

    emit(
      state.productsUpdated(
        item: updatedItem,
      ),
    );
  }

  void updateQuantityPackage(String quantity) {
    final currPackageQuantity = int.parse(quantity);

    final updatedItemQuantity =
        (currPackageQuantity * (state.selectedProduct?.packageSize ?? 1));
    packageQuantityController.text = currPackageQuantity.toString();

    quantityController.text = updatedItemQuantity.toString();
    emit(state.updateSuggestedPrice(
        quantity: updatedItemQuantity,
        totalPrice: ((double.tryParse(customPriceController.text) ?? 0) *
            updatedItemQuantity)));
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
