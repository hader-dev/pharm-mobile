import 'package:hader_pharm_mobile/models/order_claim.dart';

OrderClaimHeaderModel jsonToOrderClaimHeaderModel(Map<String, dynamic> json) {
  return OrderClaimHeaderModel(
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
    displayId: json['displayId'] as String,
    id: json['id'] as String,
    fromCompanyId: json['fromCompanyId'] as String,
    toCompanyId: json['toCompanyId'] as String,
    orderId: json['orderId'] ?? "",
    orderItemId: json['orderItemId'] ?? "",
    claimStatusId: json['statusId'] ?? 1,
    subject: json['subject'] ?? "",
  );
}

List<OrderClaimHeaderModel> jsonToOrderClaimHeaderModelList(List<dynamic> json) {
  return json.map((claim) => jsonToOrderClaimHeaderModel(claim)).toList();
}
