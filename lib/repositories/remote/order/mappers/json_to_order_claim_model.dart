


import 'package:hader_pharm_mobile/models/order_claim.dart';

OrderClaimModel jsonToOrderClaimModel(Map<String, dynamic> json) {
  return OrderClaimModel(
    id: json['id'] as String,
    fromCompanyId: json['fromCompanyId'] as String,
    toCompanyId: json['toCompanyId'] as String,
    orderId: json['orderId'] as String,
    orderItemId: json['orderItemId'] as String,
    claimStatusId: json['claimStatusId'] as int,
    subject: json['subject'] as String,
    description: json['description'] as String,
  );
}


List<OrderClaimModel> jsonToOrderClaimModelList(List<dynamic> json) {
  return json.map((claim) => jsonToOrderClaimModel(claim)).toList();
}