import 'package:hader_pharm_mobile/repositories/remote/order/mappers/json_to_order_item_claim.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_order_complaints.dart';

ResponseOrderComplaints jsonToOrderComplaintResponse(
    Map<String, dynamic> json) {
  final totalItems = json['totalItems'] ?? 0;
  final data = jsonToOrderClaimHeaderModelList(json['data'] ?? []);
  return ResponseOrderComplaints(claims: data, totalItems: totalItems);
}
