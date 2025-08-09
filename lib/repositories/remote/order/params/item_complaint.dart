


class ParamsGetComplaint{
  final String orderId;
  final String itemId;
  ParamsGetComplaint({required this.orderId,required this.itemId});
}


class ParamsMakeComplaint{
  final String orderId;
  final String itemId;
  final String description;
  final String subject;
  ParamsMakeComplaint( {required this.subject, required this.orderId,required this.itemId,required this.description});
}