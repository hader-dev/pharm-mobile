import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/models/deligate_order.dart';
import 'package:hader_pharm_mobile/models/order_details.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/cancel_order.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/delete_order_item.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_order_cancel.dart';
import 'package:hader_pharm_mobile/utils/debounce.dart';

part 'orders_details_state.dart';

class OrderDetailsCubit extends Cubit<OrdersDetailsState> {
  OrderDetailsModel? orderData;
  final IOrderRepository orderRepository;
  List<DeligateOrderItem> orderItems = [];
  DebouncerManager debounceManager = DebouncerManager();

  OrderDetailsCubit({
    required this.orderRepository,
  }) : super(OrdersInitial());

  Future<void> getOrdersDetails({required String orderId}) async {
    try {
      emit(OrderDetailsLoading());

      var results = await Future.wait([
        orderRepository.getMOrderById(orderId),
      ]);

      final orderData = results[0];

      this.orderData = orderData;
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

      emit(OrderDetailsLoaded());
    } catch (e, stacktrace) {
      debugPrint("$e");
      debugPrintStack(stackTrace: stacktrace);

      emit(OrderDetailsLoadingFailed());
    }
  }

  Future<void> reloadOrderData() async {
    try {
      emit(OrderDetailsLoading());
      orderData = await orderRepository.getMOrderById(orderData!.id);
      emit(OrderDetailsLoaded());
    } catch (e, stacktrace) {
      debugPrint("$e");
      debugPrintStack(stackTrace: stacktrace);

      emit(OrderDetailsLoadingFailed());
    }
  }

  Future<ResponseOrderCancel> cancelOrder() async {
    if (orderData == null) return ResponseOrderCancel.error();
    return orderRepository.cancelOrder(ParamsCancelOrder(id: orderData!.id));
  }

  void removeOrderItem(DeligateOrderItem item) {
    orderItems =
        orderItems.where((el) => el.product.id != item.product.id).toList();
    orderRepository.deleteOrderItem(
        ParamsDeleteOrderItem(orderId: orderData!.id, itemId: item.product.id));
    emit(OrderDetailsLoaded());
  }

  void decrementItemQuantity(
      DeligateOrderItem item,
      TextEditingController itemQuantityController,
      TextEditingController itemCustomPriceController) {
    final quantity = int.parse(itemQuantityController.text);
    final updatedQuantity = quantity > 1 ? quantity - 1 : 1;

    itemQuantityController.text = updatedQuantity.toString();

    final updatedItem = item.copyWith(quantity: updatedQuantity);

    orderItems = orderItems
        .map((el) => el.product.id == item.product.id ? updatedItem : el)
        .toList();
    emit(OrderDetailsLoaded());
  }

  void incrementItemQuantity(
      DeligateOrderItem item,
      TextEditingController itemQuantityController,
      TextEditingController itemCustomPriceController) {
    final quantity = int.parse(itemQuantityController.text);

    final updatedQuantity = quantity + 1;

    itemQuantityController.text = updatedQuantity.toString();

    final updatedItem = item.copyWith(quantity: updatedQuantity);
    orderItems = orderItems
        .map((el) => el.product.id == item.product.id ? updatedItem : el)
        .toList();

    emit(OrderDetailsLoaded());
  }

  void updateItemCustomPrice(String value, DeligateOrderItem item) {
    debounceManager.debounce(
        tag: "price",
        duration: const Duration(milliseconds: 1000),
        action: () {
          final priceValue = double.tryParse(value);
          final updatedItem = item.copyWith(suggestedPrice: priceValue);
          orderItems = orderItems
              .map((el) => el.product.id == item.product.id ? updatedItem : el)
              .toList();
          emit(OrderDetailsLoaded());
        });
  }

  void updateCustomQuantity(String value, DeligateOrderItem item) {
    debounceManager.debounce(
        tag: "quantity",
        duration: const Duration(milliseconds: 1000),
        action: () {
          final quantityValue = int.tryParse(value);
          final updatedItem = item.copyWith(quantity: quantityValue);
          orderItems = orderItems
              .map((el) => el.product.id == item.product.id ? updatedItem : el)
              .toList();
          emit(OrderDetailsLoaded());
        });
  }
}
