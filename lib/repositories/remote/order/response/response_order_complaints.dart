import 'package:hader_pharm_mobile/models/order_claim.dart';

class ResponseOrderComplaints {
  final List<OrderClaimHeaderModel> claims;
  final int totalItems;
  ResponseOrderComplaints({this.claims = const [], this.totalItems = 0});
}
