class OrderClaimModel {
  final String id;
  final String displayId;
  final String fromCompanyId;
  final String toCompanyId;
  final String orderId;

  final String orderItemId;
  final int claimStatusId;

  final String subject;
  final String description;

  final DateTime createdAt;
  final DateTime updatedAt;

  OrderClaimModel(
      {required this.id,
      required this.displayId,
      required this.fromCompanyId,
      required this.toCompanyId,
      required this.orderId,
      required this.orderItemId,
      required this.claimStatusId,
      required this.subject,
      required this.description,
      required this.createdAt,
      required this.updatedAt});

  factory OrderClaimModel.empty() {
    return OrderClaimModel(
        id: "",
        displayId: "",
        fromCompanyId: "",
        toCompanyId: "",
        orderId: "",
        orderItemId: "",
        claimStatusId: 0,
        subject: "",
        description: "",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now());
  }
}

class OrderClaimHeaderModel {
  final String id;
  final String displayId;
  final String fromCompanyId;
  final String toCompanyId;
  final String orderId;

  final String orderItemId;
  final int claimStatusId;
  final String subject;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderClaimHeaderModel(
      {required this.id,
      required this.displayId,
      required this.createdAt,
      required this.subject,
      required this.fromCompanyId,
      required this.toCompanyId,
      required this.orderId,
      required this.orderItemId,
      required this.claimStatusId,
      required this.updatedAt});
}

class ClaimStatusHistoryModel {
  final String id;
  final String calimId;
  final String note;
  final DateTime createdAt;
  final String updatedByUserId;
  final int claimStatusId;

  ClaimStatusHistoryModel(
      {required this.claimStatusId,
      required this.id,
      required this.calimId,
      required this.note,
      required this.createdAt,
      required this.updatedByUserId});
}
