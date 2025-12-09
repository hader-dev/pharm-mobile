import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/language_config/resources/app_localizations.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
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
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';

part 'create_order_state.dart';

class DeligateCreateOrderCubit extends Cubit<DeligateCreateOrderState> {
  final IParaPharmaRepository parapharmaRepo;
  final IOrderRepository orderRepo;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DebounceManager debounceManager = DebounceManager();

  DeligateCreateOrderCubit({
    required this.parapharmaRepo,
    required this.orderRepo,
    required ScrollController scrollController,
    required TextEditingController packageQuantityController,
    required TextEditingController searchController,
    required TextEditingController quantityController,
    required TextEditingController customPriceController,
    required String shippingAddress,
  }) : super(DeligateOrderInitial(
          client: DeligateClient.empty(),
          packageQuantityController: packageQuantityController,
          searchController: searchController,
          quantityController: quantityController,
          customPriceController: customPriceController,
          scrollController: scrollController,
          shippingAddress: shippingAddress,
        )) {
    _onScroll();
  }

  void searchProducts([String? text]) => debounceManager.debounce(tag: "search", action: () => getProducts());

  Future<void> getProducts({int offset = 0}) async {
    try {
      final searchText = state.searchController.text.trim();

      emit(state.toLoading(offset: offset));

      final response = await parapharmaRepo.getParaPharmaCatalog(
        ParamsLoadParapharma(
          limit: state.limit,
          offset: state.offSet,
          filters: ParaMedicalFilters(
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

  Future<void> loadMoreClients() async {
    try {
      if (state.offSet >= state.totalItemsCount) {
        emit(state.toLimitReached());
        return;
      }

      final offSet = state.offSet + state.limit;
      emit(state.toLoading(offset: offSet));

      final response = await parapharmaRepo.getParaPharmaCatalog(ParamsLoadParapharma(
        limit: state.limit,
        offset: offSet,
        includeFavorites: false,
      ));

      emit(state.toLoaded(
        products: response.data,
        totalItemsCount: response.totalItems,
        hasReachedMax: response.data.length >= response.totalItems,
      ));
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      debugPrint("Error loading more announcements: $e");
      emit(state.toFailed(
        "Failed to load more announcements",
      ));
    }
  }

  Future<void> refreshProducts() async {
    emit(state.toInitial());
    await getProducts();
  }

  void _onScroll() {
    state.scrollController.addListener(() async {
      if (state.scrollController.position.pixels >= state.scrollController.position.maxScrollExtent) {
        if (state.offSet < state.totalItemsCount) {
          await loadMoreClients();
        } else {
          emit(state.toLimitReached());
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

    item.packageQuantityController.text = (updatedQuantity ~/ (item.model.product.packageSize)).toString();

    item.quantityController.text = updatedQuantity.toString();

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
    final tempQuantity = int.parse(item.quantityController.text);

    final updatedQuantity = tempQuantity + 1;

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
    emit(state.toUpdateSelectedProduct(product: product));
    state.customPriceController.text = product.unitPriceHt.toString();
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

  void addOrderItem() {
    if (state.selectedProduct == null) return;
    final translation = AppLayout.appLayoutScaffoldKey.currentContext!.translation!;
    final quantity = state.quantity;
    final customPrice = double.tryParse(state.customPriceController.text);

    emit(
      state.toProductsUpdated(
        resetSelectedProduct: true,
        item: DeligateParahparmOrderItemUi(
            quantityController: TextEditingController(text: state.quantityController.text),
            customPriceController: TextEditingController(text: state.customPriceController.text),
            packageQuantityController: TextEditingController(text: state.packageQuantityController.text),
            model: DeligateParahparmOrderItem(
                isParapharm: true, product: state.selectedProduct!, quantity: quantity, suggestedPrice: customPrice)),
      ),
    );

    getItInstance.get<ToastManager>().showToast(
          message: translation.order_placed_successfully,
          type: ToastType.success,
        );
  }

  void removeOrderItem(DeligateParahparmOrderItemUi item) {
    emit(
      state.toProductsUpdated(
        item: item,
        removed: true,
      ),
    );
  }

  void updateClient(DeligateClient client) {
    emit(state.toClientUpdated(client: client));
  }

  void decrementPackageItemQuantity({
    required DeligateParahparmOrderItemUi item,
  }) {
    final currPackageQuantity = int.parse(item.packageQuantityController.text) - 1;

    final updatedItemQuantity = (currPackageQuantity * (item.model.product.packageSize));

    item.packageQuantityController.text = (currPackageQuantity < 1 ? 1 : currPackageQuantity).toString();

    item.quantityController.text = (updatedItemQuantity < 1 ? 1 : updatedItemQuantity).toString();

    final updatedItem = item.copyWith(model: item.model.copyWith(quantity: updatedItemQuantity));

    emit(
      state.toProductsUpdated(
        item: updatedItem,
      ),
    );
  }

  void incrementPackageItemQuantity({
    required DeligateParahparmOrderItemUi item,
  }) {
    final currPackageQuantity = int.parse(item.packageQuantityController.text) + 1;

    final updatedItemQuantity = (currPackageQuantity * (item.model.product.packageSize));

    item.packageQuantityController.text = currPackageQuantity.toString();

    item.quantityController.text = updatedItemQuantity.toString();

    final updatedItem = item.copyWith(model: item.model.copyWith(quantity: updatedItemQuantity));

    emit(
      state.toProductsUpdated(
        item: updatedItem,
      ),
    );
  }

  void decrementPackageQuantity() {
    final currPackageQuantity = int.parse(state.packageQuantityController.text) - 1;

    final updatedItemQuantity = (currPackageQuantity * (state.selectedProduct?.packageSize ?? 1));

    state.packageQuantityController.text = (currPackageQuantity < 1 ? 1 : currPackageQuantity).toString();

    state.quantityController.text = (updatedItemQuantity < 1 ? 1 : updatedItemQuantity).toString();
    emit(state.toUpdateSuggestedPrice(
        quantity: updatedItemQuantity,
        totalPrice: ((double.tryParse(state.customPriceController.text) ?? 0) * updatedItemQuantity)));
  }

  void incrementPackageQuantity() {
    final currPackageQuantity = int.parse(state.packageQuantityController.text) + 1;

    final updatedItemQuantity = (currPackageQuantity * (state.selectedProduct?.packageSize ?? 1));

    state.packageQuantityController.text = currPackageQuantity.toString();

    state.quantityController.text = updatedItemQuantity.toString();
    emit(state.toUpdateSuggestedPrice(
        quantity: updatedItemQuantity,
        totalPrice: ((double.tryParse(state.customPriceController.text) ?? 0) * updatedItemQuantity)));
  }

  void updateItemQuantity({
    required DeligateParahparmOrderItemUi item,
  }) {
    final updatedItemQuantity = int.parse(item.quantityController.text);

    state.packageQuantityController.text = (updatedItemQuantity ~/ item.model.product.packageSize).toString();

    item.quantityController.text = updatedItemQuantity.toString();

    final updatedItem = item.copyWith(model: item.model.copyWith(quantity: updatedItemQuantity));

    emit(
      state.toProductsUpdated(
        item: updatedItem,
      ),
    );
  }

  void updateItemPackageQuantity({
    required DeligateParahparmOrderItemUi item,
  }) {
    final currPackageQuantity = int.parse(item.packageQuantityController.text);

    final updatedItemQuantity = (currPackageQuantity * (item.model.product.packageSize));
    item.packageQuantityController.text = currPackageQuantity.toString();

    item.quantityController.text = updatedItemQuantity.toString();

    final updatedItem = item.copyWith(model: item.model.copyWith(quantity: updatedItemQuantity));

    emit(
      state.toProductsUpdated(
        item: updatedItem,
      ),
    );
  }

  void updateQuantityPackage(String quantity) {
    final currPackageQuantity = int.parse(quantity);

    final updatedItemQuantity = (currPackageQuantity * (state.selectedProduct?.packageSize ?? 1));
    state.packageQuantityController.text = currPackageQuantity.toString();

    state.quantityController.text = updatedItemQuantity.toString();
    emit(state.toUpdateSuggestedPrice(
        quantity: updatedItemQuantity,
        totalPrice: ((double.tryParse(state.customPriceController.text) ?? 0) * updatedItemQuantity)));
  }

  void updateQuantity(String quantity) {
    final updatedQuantity = int.parse(quantity);

    state.quantityController.text = updatedQuantity.toString();

    state.packageQuantityController.text = (updatedQuantity ~/ (state.selectedProduct?.packageSize ?? 1)).toString();

    emit(state.toUpdateSuggestedPrice(
        quantity: updatedQuantity,
        totalPrice: ((double.tryParse(state.customPriceController.text) ?? 0) * updatedQuantity)));
  }

  void addProvidedOrderItem(
    DeligateParahparmOrderItemUi item,
  ) {
    final translation = AppLayout.appLayoutScaffoldKey.currentContext!.translation!;

    emit(
      state.toProductsUpdated(item: item),
    );

    RoutingManager.router.pop();
    getItInstance.get<ToastManager>().showToast(
          message: translation.cart_item_added_successfully,
          type: ToastType.success,
        );
  }

  void changeOrderNote(String note) {
    emit(
      state.toUpdateMiscs(orderNote: note),
    );
  }

  void clearItems(AppLocalizations appLocalizations) {
    emit(state.toClearProducts());
  }

  void updateShippingAddress(String shippingAddress) {
    emit(
      state.toUpdateMiscs(shippingAddress: shippingAddress),
    );
  }

  void updatePaymentMethod(PaymentMethods paymentMethod) {
    emit(
      state.toUpdateMiscs(selectedPaymentMethod: paymentMethod),
    );
  }

  void updateInvoiceType(InvoiceTypes invoiceType) {
    emit(
      state.toUpdateMiscs(selectedInvoiceType: invoiceType),
    );
  }

  Future<void> submitOrder() async {
    await submitOrderWithClient(state.client);
  }

  Future<void> submitOrderWithClient(DeligateClient client) async {
    final context = AppLayout.appLayoutScaffoldKey.currentContext!;
    final translation = context.translation!;
    final messanger = getItInstance.get<ToastManager>();

    if (state.orderProducts.isEmpty || client.id.isEmpty) {
      messanger.showToast(type: ToastType.error, message: translation.feedback_select_client_and_add_items);
      return;
    }

    try {
      final userManager = getItInstance<UserManager>();
      await orderRepo.createDeligateOrder(ParamsCreateDeligateOrder(
        deliveryAddress: userManager.currentUser.address,
        deliveryTownId: userManager.currentUser.townId,
        orderItems: state.orderProducts.map((el) => el.model).toList(),
        clientId: client.buyerCompany.managerUserId!,
        clientCompanyId: client.buyerCompany.id,
      ));

      RoutingManager.router.pop();
      messanger.showToast(type: ToastType.success, message: translation.order_placed_successfully);

      emit(state.toInitial());
    } catch (e) {
      messanger.showToast(type: ToastType.error, message: translation.order_placed_failed);
    }
  }
}
