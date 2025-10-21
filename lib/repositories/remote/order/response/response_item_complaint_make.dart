import 'package:hader_pharm_mobile/models/order_claim.dart';
import 'package:hader_pharm_mobile/models/order_details.dart';

class ResponseItemComplaintMake {
  final OrderClaimModel? orderClaimModel;
  final OrderItem? orderItemModel;
  final List<ClaimStatusHistoryModel>? claimStatusHistory;

  ResponseItemComplaintMake(
      {this.orderClaimModel,
      this.orderItemModel,
      this.claimStatusHistory = const []});
}
