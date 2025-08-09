

import 'package:hader_pharm_mobile/models/order_claim.dart';

OrderClaimHeaderModel jsonToOrderClaimHeaderModel(Map<String, dynamic> json) {
  return OrderClaimHeaderModel(
    createdAt: DateTime.parse(json['createdAt'] as String),
    id: json['id'] as String,
    fromCompanyId: json['fromCompanyId'] as String,
    toCompanyId: json['toCompanyId'] as String,
    orderId: json['orderId'] as String,
    orderItemId: json['orderItemId'] as String,
    claimStatusId: json['claimStatusId'] as int,
    subject: json['subject'] as String,
  );
}

List<OrderClaimHeaderModel> jsonToOrderClaimHeaderModelList(List<dynamic> json) {
  return json.map((claim) => jsonToOrderClaimHeaderModel(claim)).toList();
}
