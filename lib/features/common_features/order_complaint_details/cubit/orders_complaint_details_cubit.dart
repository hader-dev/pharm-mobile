import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/routes/go_router_extension.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/models/order_claim.dart';
import 'package:hader_pharm_mobile/models/order_details.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/item_complaint.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_item_complaint_make.dart';

part 'orders_complaint_details_state.dart';

class OrderComplaintsCubit extends Cubit<OrdersComplaintState> {
  OrderClaimModel? claimData;
  OrderItem? orderItemData;

  final IOrderRepository orderRepository;
  final String orderId;
  final String? itemId;
  final String complaintId;

  String subject = '';
  String description = '';

  List<ClaimStatusHistoryModel> complaintStatusHitsory = [];

  OrderComplaintsCubit({
    required this.orderId,
    this.itemId,
    required this.complaintId,
    required this.orderRepository,
  }) : super(OrdersComplaintsInitial());

  Future<void> getItemComplaint() async {
    try {
      emit(OrderComplaintsLoading());
      final res = await orderRepository.findComplaint(
          ParamsGetComplaint(orderId: orderId, complaintId: complaintId));

      if (res.orderClaimModel == null) {
        emit(OrderComplaintsLoadingFailed());
        return;
      }

      claimData = res.orderClaimModel!;
      orderItemData = res.orderItemModel;
      complaintStatusHitsory = res.claimStatusHistory;

      emit(OrderComplaintsLoaded());
    } catch (e, stacktrace) {
      debugPrint("$e");
      debugPrintStack(stackTrace: stacktrace);

      emit(OrderComplaintsLoadingFailed());
    }
  }

  Future<void> reloadComplaint() async {
    try {
      emit(OrderComplaintsLoading());

      final res = await orderRepository.findComplaint(
          ParamsGetComplaint(orderId: orderId, complaintId: complaintId));
      if (res.orderClaimModel == null) {
        emit(OrderComplaintsLoadingFailed());
        return;
      }
      claimData = res.orderClaimModel!;
      orderItemData = res.orderItemModel;
      complaintStatusHitsory = res.claimStatusHistory;

      emit(OrderComplaintsLoaded());
    } catch (e, stacktrace) {
      debugPrint("$e");
      debugPrintStack(stackTrace: stacktrace);

      emit(OrderComplaintsLoadingFailed());
    }
  }

  Future<ResponseItemComplaintMake> makeComplaint() async {
    if (subject.isEmpty || description.isEmpty) {
      return ResponseItemComplaintMake();
    }

    emit(OrderComplaintsLoading());
    try {
      final res = await orderRepository.makeComplaint(ParamsMakeComplaint(
        subject: subject,
        orderId: orderId,
        description: description,
      ));

      emit(OrderComplaintsLoaded());

      RoutingManager.router.safePop();

      return res;
    } catch (e) {
      emit(OrderComplaintsLoadingFailed());
      return ResponseItemComplaintMake();
    }
  }

  void updateClaimSubject(String? v) {
    subject = v ?? '';
  }

  void updateClaimDescription(String? v) {
    description = v ?? '';
  }
}
