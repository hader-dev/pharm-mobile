import 'package:hader_pharm_mobile/models/order_claim.dart';
import 'package:hader_pharm_mobile/models/order_details.dart';

class ResponseItemComplaintFind {
  final OrderClaimModel? orderClaimModel;

  final OrderItem? orderItemModel;

  final List<ClaimStatusHistoryModel> claimStatusHistory;

  ResponseItemComplaintFind(
      {this.orderClaimModel,
      this.orderItemModel,
      this.claimStatusHistory = const []});
}
