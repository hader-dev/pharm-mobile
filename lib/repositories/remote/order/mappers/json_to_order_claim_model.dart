import 'package:hader_pharm_mobile/models/order_claim.dart';

OrderClaimModel jsonToOrderClaimModel(Map<String, dynamic> json) {
  return OrderClaimModel(
    id: json['id'],
    fromCompanyId: json['fromCompanyId'],
    toCompanyId: json['toCompanyId'],
    orderId: json['orderId'],
    orderItemId: json['orderItemId'] ?? "",
    claimStatusId: json['complaintStatus'] ?? 1,
    subject: json['subject'] ?? "unkown",
    description: json['description'] ?? "unkown",
  );
}

List<OrderClaimModel> jsonToOrderClaimModelList(List<dynamic> json) {
  return json.map((claim) => jsonToOrderClaimModel(claim)).toList();
}
