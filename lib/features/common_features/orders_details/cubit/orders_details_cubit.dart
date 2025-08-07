import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/cancel_order.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_order_cancel.dart';

import '../../../../models/order_details.dart';
import '../../../../repositories/remote/order/order_repository_impl.dart';

part 'orders_details_state.dart';

class OrderDetailsCubit extends Cubit<OrdersDetailsState> {
  OrderDetailsModel? orderData;
  final OrderRepository orderRepository;

  OrderDetailsCubit({
    required this.orderRepository,
  }) : super(OrdersInitial());

  Future<void> getOrdersDetails({required String orderId}) async {
    try {
      emit(OrderDetailsLoading());

      orderData = await orderRepository.getMOrderById(orderId);
      emit(OrderDetailsLoaded());
    } catch (e, stacktrace) {
      debugPrint("$e");
      debugPrintStack(stackTrace: stacktrace);

      emit(OrderDetailsLoadingFailed());
    }
  }

  Future<ResponseOrderCancel> cancelOrder() async {
    if(orderData == null) return ResponseOrderCancel.error();
    return orderRepository.cancelOrder(ParamsCancelOrder(id: orderData!.id));
  }
}
