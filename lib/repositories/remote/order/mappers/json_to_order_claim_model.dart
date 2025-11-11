import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/models/order_claim.dart';

OrderClaimModel jsonToOrderClaimModel(Map<String, dynamic> json) {
  debugPrint("claim: $json");
  return OrderClaimModel(
    id: json['id'] ?? "",
    fromCompanyId: json['fromCompanyId'] ?? "",
    toCompanyId: json['toCompanyId'] ?? "",
    orderId: json['orderId'] ?? "",
    orderItemId: json['orderItemId'] ?? "",
    claimStatusId: json['complaintStatus'] ?? 1,
    subject: json['subject'] ?? "unkown",
    description: json['description'] ?? "unkown",
  );
}

List<OrderClaimModel> jsonToOrderClaimModelList(List<dynamic> json) {
  return json.map((claim) => jsonToOrderClaimModel(claim)).toList();
}

ClaimStatusHistoryModel jsonToOrderClaimStatusHistory(
    Map<String, dynamic> json) {
  return ClaimStatusHistoryModel(
    id: json['id'],
    createdAt: DateTime.parse(json['createdAt']),
    note: json['note'] ?? '',
    claimStatusId: json['status'] ?? 1,
    calimId: json['complaintId'] ?? '',
    updatedByUserId: json['changedByUserId'] ?? '',
  );
}

List<ClaimStatusHistoryModel> jsonToOrderClaimStatusHistoryList(
    List<dynamic> json) {
  return json.map((claim) => jsonToOrderClaimStatusHistory(claim)).toList();
}
