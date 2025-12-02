import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/language_config/resources/app_localizations.dart';
import 'package:hader_pharm_mobile/models/deligate_order.dart';
import 'package:hader_pharm_mobile/models/order_change.dart';
import 'package:hader_pharm_mobile/models/order_details.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/cancel_order.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/update_order.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_order_cancel.dart';
import 'package:hader_pharm_mobile/utils/debounce.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';

part 'orders_details_state.dart';

class OrderDetailsCubit extends Cubit<OrdersDetailsState> {
  final IOrderRepository orderRepository;
  DebouncerManager debounceManager = DebouncerManager();
  OrderChangeModel orderChangeModel = OrderChangeModel();

  OrderDetailsCubit({
    required this.orderRepository,
  }) : super(OrdersInitial());

  Future<void> getOrdersDetails({required String orderId}) async {
    try {
      emit(state.loading());

      var results = await Future.wait([
        orderRepository.getOrderById(orderId),
      ]);

      final orderData = results[0];

      final orderItems = <DeligateOrderItemUi>[];

      for (var element in orderData.orderItems) {
        orderItems.add(
          DeligateOrderItemUi(
            model: DeligateOrderItem(
              product: element,
              quantity: element.quantity,
              isParapharm: element.paraPharmCatalogId != null,
              suggestedPrice: element.unitPriceHt,
            ),
            quantityController: TextEditingController(text: element.quantity.toString()),
            packageQuantityController:
                TextEditingController(text: (element.quantity ~/ element.packageSize).toString()),
            customPriceController: TextEditingController(text: element.unitPriceHt.toString()),
          ),
        );
      }

      emit(state.loaded(
        orderData: orderData,
        orderItems: orderItems,
        originalOrderItems: orderItems.map((el) => el).toList(),
      ));
    } catch (e, stacktrace) {
      debugPrint("$e");
      debugPrintStack(stackTrace: stacktrace);

      emit(state.loadingFailed());
    }
  }

  Future<void> reloadOrderData() async {
    try {
      emit(state.loading());
      final orderData = await orderRepository.getOrderById(state.orderData.id);
      final orderItems = <DeligateOrderItemUi>[];

      for (var element in orderData.orderItems) {
        orderItems.add(
          DeligateOrderItemUi(
            model: DeligateOrderItem(
              product: element,
              quantity: element.quantity,
              isParapharm: element.paraPharmCatalogId != null,
              suggestedPrice: element.unitPriceHt,
            ),
            quantityController: TextEditingController(text: element.quantity.toString()),
            packageQuantityController:
                TextEditingController(text: (element.quantity ~/ element.packageSize).toString()),
            customPriceController: TextEditingController(text: element.unitPriceHt.toString()),
          ),
        );
      }

      emit(state.loaded(orderData: orderData, orderItems: orderItems, originalOrderItems: orderItems));
    } catch (e, stacktrace) {
      debugPrint("$e");
      debugPrintStack(stackTrace: stacktrace);

      emit(state.loadingFailed());
    }
  }

  Future<ResponseOrderCancel> cancelOrder() async {
    if (state.orderData.id == "empty") return ResponseOrderCancel.error();
    return orderRepository.cancelOrder(ParamsCancelOrder(id: state.orderData.id));
  }

  void removeOrderItem(DeligateOrderItemUi item) {
    final orderItems = state.orderItems.where((el) => el.model.product.id != item.model.product.id).toList();

    orderChangeModel.removeOrderItem(item.model);

    emit(state.toInitial(orderItems: orderItems, didChange: true));
  }

  void decrementItemQuantity(
    DeligateOrderItemUi item,
  ) {
    final quantity = int.parse(item.quantityController.text);
    final updatedQuantity = quantity > 1 ? quantity - 1 : 1;

    item.quantityController.text = updatedQuantity.toString();

    final updatedItem = item.copyWith(model: item.model.copyWith(quantity: updatedQuantity));

    final orderItems =
        state.orderItems.map((el) => el.model.product.id == item.model.product.id ? updatedItem : el).toList();

    orderChangeModel.updateOrderItem(updatedItem.model);

    emit(state.toInitial(
      orderItems: orderItems,
      didChange: true,
    ));
  }

  void incrementItemQuantity(
    DeligateOrderItemUi item,
  ) {
    final quantity = int.parse(item.quantityController.text);

    final updatedQuantity = quantity + 1;

    item.quantityController.text = updatedQuantity.toString();

    final updatedItem = item.copyWith(model: item.model.copyWith(quantity: updatedQuantity));
    orderChangeModel.updateOrderItem(updatedItem.model);

    final orderItems =
        state.orderItems.map((el) => el.model.product.id == item.model.product.id ? updatedItem : el).toList();

    emit(state.toInitial(
      orderItems: orderItems,
      didChange: true,
    ));
  }

  void updateItemCustomPrice(String value, DeligateOrderItemUi item) {
    debounceManager.debounce(
        tag: "price",
        duration: const Duration(milliseconds: 1000),
        action: () {
          final priceValue = double.tryParse(value);
          final updatedItem = item.copyWith(model: item.model.copyWith(suggestedPrice: priceValue));
          final orderItems =
              state.orderItems.map((el) => el.model.product.id == item.model.product.id ? updatedItem : el).toList();

          orderChangeModel.updateOrderItem(updatedItem.model);
          emit(state.toInitial(
            orderItems: orderItems,
            didChange: true,
          ));
        });
  }

  void updateCustomQuantity(String value, DeligateOrderItemUi item) {
    debounceManager.debounce(
        tag: "quantity",
        duration: const Duration(milliseconds: 1000),
        action: () {
          final quantityValue = int.tryParse(value);
          final updatedItem = item.copyWith(model: item.model.copyWith(quantity: quantityValue));
          final orderItems =
              state.orderItems.map((el) => el.model.product.id == item.model.product.id ? updatedItem : el).toList();

          orderChangeModel.updateOrderItem(updatedItem.model);

          emit(state.toInitial(
            orderItems: orderItems,
            didChange: true,
          ));
        });
  }

  void cancelUpdateOrder() {
    orderChangeModel.reset();
    emit(
      state.toCancelChanges(),
    );
  }

  void confirmUpdateOrder(AppLocalizations translation) {
    orderRepository
        .updateOrder(
      ParamsUpdateOrder(
        orderId: state.orderData.id,
        deleteOrderItems: orderChangeModel.deleteOrderItems.toList(),
        updateOrderItems: orderChangeModel.updateOrderItems.toList(),
        addOrderItems: orderChangeModel.addOrderItems.toList(),
      ),
    )
        .then((res) {
      final toastManager = getItInstance.get<ToastManager>();
      toastManager.showToast(
        message: res.affectedRows > 0 ? translation.feedback_action_success : translation.feedback_action_failed,
        type: res.affectedRows > 0 ? ToastType.success : ToastType.error,
      );

      if (res.affectedRows > 0) {
        orderChangeModel.reset();

        emit(
          state.toInitial(
            didChange: false,
          ),
        );
      }
    });
  }

  void addOrderItem({
    required TextEditingController customPriceController,
    required int quantity,
    BaseParaPharmaCatalogModel? selectedProduct,
    required AppLocalizations translation,
  }) {
    if (selectedProduct == null) return;

    final customPrice = double.tryParse(customPriceController.text);

    final newOrderItem = DeligateOrderItemUi(
      model: DeligateOrderItem(
          isParapharm: true,
          product: OrderItem.empty().copyWith(
            paraPharmCatalogId: selectedProduct.id,
            designation: selectedProduct.name,
            imageUrl: selectedProduct.image?.path,
            packageSize: selectedProduct.packageSize,
          ),
          quantity: quantity,
          suggestedPrice: customPrice),
      quantityController: TextEditingController(text: quantity.toString()),
      customPriceController: TextEditingController(text: customPrice.toString()),
      packageQuantityController: TextEditingController(text: (quantity ~/ (selectedProduct.packageSize)).toString()),
    );

    orderChangeModel.addOrderItem(newOrderItem.model);

    emit(state.toItemsUpdated(item: newOrderItem));

    getItInstance.get<ToastManager>().showToast(
          message: translation.order_placed_successfully,
          type: ToastType.success,
        );
  }

  void decrementPackageItemQuantity({
    required DeligateOrderItemUi item,
  }) {
    final tempQuantity = int.parse(item.quantityController.text);
    final updatedQuantity = tempQuantity - 1 < 1 ? 1 : tempQuantity - 1;

    item.quantityController.text = updatedQuantity.toString();

    final updatedItem = item.copyWith(model: item.model.copyWith(quantity: updatedQuantity));
    orderChangeModel.updateOrderItem(updatedItem.model);

    final orderItems =
        state.orderItems.map((el) => el.model.product.id == item.model.product.id ? updatedItem : el).toList();

    emit(state.toInitial(
      orderItems: orderItems,
      didChange: true,
    ));
  }

  void incrementPackageItemQuantity({
    required DeligateOrderItemUi item,
  }) {
    final updatedQuantity = int.parse(item.quantityController.text) + 1;

    item.quantityController.text = updatedQuantity.toString();

    final updatedItem = item.copyWith(model: item.model.copyWith(quantity: updatedQuantity));
    orderChangeModel.updateOrderItem(updatedItem.model);

    final orderItems =
        state.orderItems.map((el) => el.model.product.id == item.model.product.id ? updatedItem : el).toList();

    emit(state.toInitial(
      orderItems: orderItems,
      didChange: true,
    ));
  }

  void updateItemQuantity({
    required DeligateOrderItemUi item,
  }) {
    final updatedQuantity = int.parse(item.quantityController.text);

    final updatedItem = item.copyWith(model: item.model.copyWith(quantity: updatedQuantity));
    orderChangeModel.updateOrderItem(updatedItem.model);

    item.packageQuantityController.text = (updatedQuantity ~/ (item.model.product.packageSize)).toString();

    final orderItems =
        state.orderItems.map((el) => el.model.product.id == item.model.product.id ? updatedItem : el).toList();

    emit(state.toInitial(
      orderItems: orderItems,
      didChange: true,
    ));
  }

  void updateItemQuantityPackage({
    required DeligateOrderItemUi item,
  }) {
    final updatedQuantity = int.parse(item.packageQuantityController.text);

    item.quantityController.text = (updatedQuantity * (item.model.product.packageSize)).toString();

    final updatedItem = item.copyWith(model: item.model.copyWith(quantity: updatedQuantity));
    orderChangeModel.updateOrderItem(updatedItem.model);

    final orderItems =
        state.orderItems.map((el) => el.model.product.id == item.model.product.id ? updatedItem : el).toList();

    emit(state.toInitial(
      orderItems: orderItems,
      didChange: true,
    ));
  }
}
