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
        orderRepository.getMorderById(orderId),
      ]);

      final orderData = results[0];

      final orderItems = <DeligateOrderItem>[];

      for (var element in orderData.orderItems) {
        orderItems.add(
          DeligateOrderItem(
            product: element,
            quantity: element.quantity,
            isParapharm: element.parapharmCatalogId != null,
            suggestedPrice: element.unitPriceHt,
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
      final orderData = await orderRepository.getMorderById(state.orderData.id);
      emit(state.loaded(orderData: orderData));
    } catch (e, stacktrace) {
      debugPrint("$e");
      debugPrintStack(stackTrace: stacktrace);

      emit(state.loadingFailed());
    }
  }

  Future<ResponseOrderCancel> cancelOrder() async {
    if (state.orderData.id == "empty") return ResponseOrderCancel.error();
    return orderRepository
        .cancelOrder(ParamsCancelOrder(id: state.orderData.id));
  }

  void removeOrderItem(DeligateOrderItem item) {
    final orderItems = state.orderItems
        .where((el) => el.product.id != item.product.id)
        .toList();

    orderChangeModel.removeOrderItem(item);

    emit(state.initial(orderItems: orderItems, didChange: true));
  }

  void decrementItemQuantity(
      DeligateOrderItem item,
      TextEditingController itemQuantityController,
      TextEditingController itemCustomPriceController) {
    final quantity = int.parse(itemQuantityController.text);
    final updatedQuantity = quantity > 1 ? quantity - 1 : 1;

    itemQuantityController.text = updatedQuantity.toString();

    final updatedItem = item.copyWith(quantity: updatedQuantity);

    final orderItems = state.orderItems
        .map((el) => el.product.id == item.product.id ? updatedItem : el)
        .toList();

    orderChangeModel.updateOrderItem(updatedItem);

    emit(state.initial(
      orderItems: orderItems,
      didChange: true,
    ));
  }

  void incrementItemQuantity(
      DeligateOrderItem item,
      TextEditingController itemQuantityController,
      TextEditingController itemCustomPriceController) {
    final quantity = int.parse(itemQuantityController.text);

    final updatedQuantity = quantity + 1;

    itemQuantityController.text = updatedQuantity.toString();

    final updatedItem = item.copyWith(quantity: updatedQuantity);
    orderChangeModel.updateOrderItem(updatedItem);

    final orderItems = state.orderItems
        .map((el) => el.product.id == item.product.id ? updatedItem : el)
        .toList();

    emit(state.initial(
      orderItems: orderItems,
      didChange: true,
    ));
  }

  void updateItemCustomPrice(String value, DeligateOrderItem item) {
    debounceManager.debounce(
        tag: "price",
        duration: const Duration(milliseconds: 1000),
        action: () {
          final priceValue = double.tryParse(value);
          final updatedItem = item.copyWith(suggestedPrice: priceValue);
          final orderItems = state.orderItems
              .map((el) => el.product.id == item.product.id ? updatedItem : el)
              .toList();

          orderChangeModel.updateOrderItem(updatedItem);
          emit(state.initial(
            orderItems: orderItems,
            didChange: true,
          ));
        });
  }

  void updateCustomQuantity(String value, DeligateOrderItem item) {
    debounceManager.debounce(
        tag: "quantity",
        duration: const Duration(milliseconds: 1000),
        action: () {
          final quantityValue = int.tryParse(value);
          final updatedItem = item.copyWith(quantity: quantityValue);
          final orderItems = state.orderItems
              .map((el) => el.product.id == item.product.id ? updatedItem : el)
              .toList();

          orderChangeModel.updateOrderItem(updatedItem);

          emit(state.initial(
            orderItems: orderItems,
            didChange: true,
          ));
        });
  }

  void cancelUpdateOrder() {
    orderChangeModel.reset();
    emit(
      state.cancelChanges(),
    );
  }

  void confirmUpdateOrder(AppLocalizations translation) {
    debugPrint("Triggered confirm update order");
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
        message: res.affectedRows > 0
            ? translation.feedback_action_success
            : translation.feedback_action_failed,
        type: res.affectedRows > 0 ? ToastType.success : ToastType.error,
      );

      if (res.affectedRows > 0) {
        orderChangeModel.reset();

        emit(
          state.initial(
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
    emit(
      state.itemsUpdated(
        item: DeligateOrderItem(
            isParapharm: true,
            product: OrderItem.empty()
                .copyWith(parapharmCatalogId: selectedProduct.id),
            quantity: quantity,
            suggestedPrice: customPrice),
      ),
    );

    getItInstance.get<ToastManager>().showToast(
          message: translation.order_placed_successfully,
          type: ToastType.success,
        );
  }
}
