class ParamsGetComplaint {
  final String orderId;
  final String? itemId;
  final String complaintId;
  ParamsGetComplaint(
      {required this.orderId, this.itemId, required this.complaintId});
}

class ParamsMakeComplaint {
  final String orderId;
  final String? itemId;
  final String description;
  final String subject;
  ParamsMakeComplaint(
      {required this.subject,
      required this.orderId,
      this.itemId,
      required this.description});
}
