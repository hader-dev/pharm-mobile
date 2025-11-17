import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/language_config/resources/app_localizations.dart';
import 'package:hader_pharm_mobile/config/routes/go_router_extension.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/models/order_claim.dart';
import 'package:hader_pharm_mobile/models/order_details.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/item_complaint.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_item_complaint_make.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';

part 'orders_complaint_details_state.dart';

class OrderComplaintsCubit extends Cubit<OrdersComplaintState> {
  final IOrderRepository orderRepository;

  OrderComplaintsCubit({
    required String orderId,
    required String itemId,
    required String complaintId,
    required this.orderRepository,
  }) : super(OrdersComplaintsInitial(orderId: orderId, itemId: itemId, complaintId: complaintId));

  Future<void> getItemComplaint() async {
    try {
      emit(state.toLoading());
      final res = await orderRepository
          .findComplaint(ParamsGetComplaint(orderId: state.orderId, complaintId: state.complaintId));

      if (res.orderClaimModel == null) {
        emit(state.toLoadingFailed());
        return;
      }

      final claimData = res.orderClaimModel!;
      final orderItemData = res.orderItemModel;
      final complaintStatusHitsory = res.claimStatusHistory;

      emit(state.toLoaded(
        claimData: claimData,
        orderItemData: orderItemData ?? OrderItem.empty(),
        complaintStatusHitsory: complaintStatusHitsory,
      ));
    } catch (e, stacktrace) {
      debugPrint("$e");
      debugPrintStack(stackTrace: stacktrace);

      emit(state.toLoadingFailed());
    }
  }

  Future<void> reloadComplaint() async {
    try {
      emit(state.toLoading());

      final res = await orderRepository
          .findComplaint(ParamsGetComplaint(orderId: state.orderId, complaintId: state.complaintId));
      if (res.orderClaimModel == null) {
        emit(state.toLoadingFailed());
        return;
      }
      final claimData = res.orderClaimModel!;
      final orderItemData = res.orderItemModel;
      final complaintStatusHitsory = res.claimStatusHistory;

      emit(state.toLoaded(
        claimData: claimData,
        orderItemData: orderItemData ?? OrderItem.empty(),
        complaintStatusHitsory: complaintStatusHitsory,
      ));
    } catch (e, stacktrace) {
      debugPrint("$e");
      debugPrintStack(stackTrace: stacktrace);

      emit(state.toLoadingFailed());
    }
  }

  Future<ResponseItemComplaintMake> makeComplaint(AppLocalizations translation) async {
    if (state.subjectController.text.isEmpty || state.descriptionController.text.isEmpty) {
      return ResponseItemComplaintMake();
    }

    emit(state.toLoading());
    try {
      final res = await orderRepository.makeComplaint(ParamsMakeComplaint(
        subject: state.subjectController.text,
        orderId: state.orderId,
        description: state.descriptionController.text,
      ));

      emit(state.toLoaded(
        claimData: res.orderClaimModel ?? OrderClaimModel.empty(),
        orderItemData: res.orderItemModel ?? OrderItem.empty(),
        complaintStatusHitsory: res.claimStatusHistory ?? [],
      ));

      getItInstance.get<ToastManager>().showToast(
            message: translation.make_complaint_success,
            type: ToastType.success,
          );
      RoutingManager.router.safePop(true);

      return res;
    } catch (e) {
      emit(state.toLoadingFailed());
      return ResponseItemComplaintMake();
    }
  }
}
