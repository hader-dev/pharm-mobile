import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/models/order_claim.dart';
import 'package:hader_pharm_mobile/models/order_details.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/cancel_order.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/order_complaint.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_order_cancel.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_order_complaints.dart';

part 'orders_details_state.dart';

class OrderDetailsCubit extends Cubit<OrdersDetailsState> {
  OrderDetailsModel? orderData;
  final IOrderRepository orderRepository;

  List<OrderClaimHeaderModel> orderClaims = [];

  OrderDetailsCubit({
    required this.orderRepository,
  }) : super(OrdersInitial());

  Future<void> getOrdersDetails({required String orderId}) async {
    try {
      emit(OrderDetailsLoading());

      var results = await Future.wait([
        orderRepository.getMOrderById(orderId),
        orderRepository
            .getOrderClaims(ParamsGetOrderComplaints(orderId: orderId))
      ]);

      final orderData = results[0] as OrderDetailsModel;
      final orderClaims = results[1] as ResponseOrderComplaints;

      this.orderData = orderData;
      this.orderClaims = orderClaims.claims;

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

  Future<void> getOrderComplaints() async {
    try {
      emit(OrderDetailsLoading());

      var res = await orderRepository
          .getOrderClaims(ParamsGetOrderComplaints(orderId: orderData!.id));
      orderClaims = res.claims;

      emit(OrderDetailsLoaded());
    } catch (e, stacktrace) {
      debugPrint("$e");
      debugPrintStack(stackTrace: stacktrace);

      emit(OrderDetailsLoadingFailed());
    }
  }

}
