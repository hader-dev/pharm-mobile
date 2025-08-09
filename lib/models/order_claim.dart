class OrderClaimModel {
  final String id;
  final String fromCompanyId;
  final String toCompanyId;
  final String orderId;

  final String orderItemId;
  final int claimStatusId;

  final String subject;
  final String description;

  OrderClaimModel(
      {required this.id,
      required this.fromCompanyId,
      required this.toCompanyId,
      required this.orderId,
      required this.orderItemId,
      required this.claimStatusId,
      required this.subject,
      required this.description});
}

class OrderClaimHeaderModel {
  final String id;
  final String fromCompanyId;
  final String toCompanyId;
  final String orderId;

  final String orderItemId;
  final int claimStatusId;
  final String subject ;
  final DateTime createdAt;

  OrderClaimHeaderModel(
      {required this.id,
      required this.createdAt,
      required this.subject, 
      required this.fromCompanyId,
      required this.toCompanyId,
      required this.orderId,
      required this.orderItemId,
      required this.claimStatusId});
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
