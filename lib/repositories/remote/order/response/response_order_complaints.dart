import 'package:hader_pharm_mobile/models/order_claim.dart';

class ResponseOrderComplaints {
  final List<OrderClaimHeaderModel> claims;

  ResponseOrderComplaints({ this.claims = const []});
}
