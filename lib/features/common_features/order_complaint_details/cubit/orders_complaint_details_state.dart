part of 'orders_complaint_details_cubit.dart';

sealed class OrdersComplaintState {
  final OrderClaimModel claimData;
  final OrderItem orderItemData;

  final String orderId;
  final String itemId;
  final String complaintId;

  final String subject;
  final String description;
  final GlobalKey<FormState> complaintFormKey = GlobalKey<FormState>();
  final TextEditingController subjectController;
  final TextEditingController descriptionController;

  final List<ClaimStatusHistoryModel> complaintStatusHitsory;

  OrdersComplaintState(
      {required this.claimData,
      required this.subjectController,
      required this.descriptionController,
      required this.orderItemData,
      required this.orderId,
      required this.itemId,
      required this.complaintId,
      required this.subject,
      required this.description,
      required this.complaintStatusHitsory});

  OrdersComplaintsInitial toInitial() =>
      OrdersComplaintsInitial.fromState(state: this);

  OrderComplaintsLoading toLoading() =>
      OrderComplaintsLoading.fromState(state: this);

  OrderComplaintsLoaded toLoaded(
          {required OrderClaimModel claimData,
          required OrderItem orderItemData,
          required List<ClaimStatusHistoryModel> complaintStatusHitsory}) =>
      OrderComplaintsLoaded.fromState(
          state: this,
          claimData: claimData,
          orderItemData: orderItemData,
          complaintStatusHitsory: complaintStatusHitsory);

  OrderComplaintsLoadingFailed toLoadingFailed() =>
      OrderComplaintsLoadingFailed.fromState(state: this);

  OrderComplaintUpdate toUpdateCalim({String? description, String? subject}) =>
      OrderComplaintUpdate.fromState(
        state: this,
        subject: subject ?? this.subject,
        description: description ?? this.description,
      );
}

final class OrdersComplaintsInitial extends OrdersComplaintState {
  OrdersComplaintsInitial(
      {OrderClaimModel? claimData,
      OrderItem? orderItemData,
      String? orderId,
      String? itemId,
      String? complaintId,
      String? subject,
      String? description,
      List<ClaimStatusHistoryModel>? complaintStatusHitsory})
      : super(
          subjectController: TextEditingController(),
          descriptionController: TextEditingController(),
          claimData: claimData ?? OrderClaimModel.empty(),
          orderItemData: orderItemData ?? OrderItem.empty(),
          orderId: orderId ?? '',
          itemId: itemId ?? '',
          complaintId: complaintId ?? '',
          subject: subject ?? '',
          description: description ?? '',
          complaintStatusHitsory: complaintStatusHitsory ?? [],
        );

  OrdersComplaintsInitial.fromState({required OrdersComplaintState state})
      : super(
            claimData: state.claimData,
            orderItemData: state.orderItemData,
            orderId: state.orderId,
            itemId: state.itemId,
            complaintId: state.complaintId,
            subject: state.subject,
            description: state.description,
            complaintStatusHitsory: state.complaintStatusHitsory,
            subjectController: state.subjectController,
            descriptionController: state.descriptionController);
}

final class OrderComplaintsLoading extends OrdersComplaintState {
  OrderComplaintsLoading.fromState({
    required OrdersComplaintState state,
  }) : super(
            orderItemData: state.orderItemData,
            orderId: state.orderId,
            claimData: state.claimData,
            complaintStatusHitsory: state.complaintStatusHitsory,
            itemId: state.itemId,
            complaintId: state.complaintId,
            subject: state.subject,
            description: state.description,
            subjectController: state.subjectController,
            descriptionController: state.descriptionController);
}

final class OrderComplaintsLoaded extends OrdersComplaintState {
  OrderComplaintsLoaded.fromState({
    required super.claimData,
    required super.orderItemData,
    required super.complaintStatusHitsory,
    required OrdersComplaintState state,
  }) : super(
            orderId: state.orderId,
            itemId: state.itemId,
            complaintId: state.complaintId,
            subject: state.subject,
            description: state.description,
            subjectController: state.subjectController,
            descriptionController: state.descriptionController);
}

final class OrderComplaintsLoadingFailed extends OrdersComplaintState {
  OrderComplaintsLoadingFailed.fromState({
    required OrdersComplaintState state,
  }) : super(
            orderItemData: state.orderItemData,
            orderId: state.orderId,
            claimData: state.claimData,
            complaintStatusHitsory: state.complaintStatusHitsory,
            itemId: state.itemId,
            complaintId: state.complaintId,
            subject: state.subject,
            description: state.description,
            subjectController: state.subjectController,
            descriptionController: state.descriptionController);
}

final class OrderComplaintUpdate extends OrdersComplaintState {
  OrderComplaintUpdate.fromState(
      {required OrdersComplaintState state,
      String? subject,
      String? description})
      : super(
            claimData: state.claimData,
            subject: subject ?? state.subject,
            description: description ?? state.description,
            orderItemData: state.orderItemData,
            orderId: state.orderId,
            itemId: state.itemId,
            complaintId: state.complaintId,
            complaintStatusHitsory: state.complaintStatusHitsory,
            subjectController: state.subjectController,
            descriptionController: state.descriptionController);
}
