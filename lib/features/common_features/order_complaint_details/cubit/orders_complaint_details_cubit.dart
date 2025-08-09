import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
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
  final String itemId;

  String subject = '';
  String description = '';

  List<ClaimStatusHistoryModel> complaintStatusHitsory = [];

  OrderComplaintsCubit({
    required this.orderId,
    required this.itemId,
    required this.orderRepository,
  }) : super(OrdersComplaintsInitial());

  Future<void> getItemComplaint() async {
    try {
      emit(OrderComplaintsLoading());
      final res = await orderRepository
          .findComplaint(ParamsGetComplaint(orderId: orderId, itemId: itemId));
      if (res.orderClaimModel == null) {
        emit(OrderComplaintsLoadingFailed());
        return;
      }

      claimData = res.orderClaimModel!;
      orderItemData = res.orderItemModel!;
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

      final res = await orderRepository
          .findComplaint(ParamsGetComplaint(orderId: orderId, itemId: itemId));
      if (res.orderClaimModel == null) {
        emit(OrderComplaintsLoadingFailed());
        return;
      }
      claimData = res.orderClaimModel!;
      orderItemData = res.orderItemModel!;
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

    return orderRepository.makeComplaint(ParamsMakeComplaint(
      subject: subject,
      orderId: orderId,
      itemId: itemId,
      description: description,
    ));
  }

  void updateClaimSubject(String? v) {
    subject = v ?? '';
  }

  void updateClaimDescription(String? v) {
    description = v ?? '';
  }
}
