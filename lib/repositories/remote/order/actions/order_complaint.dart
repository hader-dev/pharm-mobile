import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/order_claim.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/mappers/json_to_order_item_claim.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/item_complaint.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/order_complaint.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_order_complaints.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<ResponseOrderComplaints> getOrderComplaints(
    ParamsGetComplaint params, INetworkService client) async {
  final queryParams = {"itemId": params.itemId, "orderId": params.orderId};
  try {
    var decodedResponse = await client.sendRequest(
        () => client.get(Urls.itemComplaint, queryParams: queryParams));

    return ResponseOrderComplaints(
        claims: jsonToOrderClaimHeaderModelList(decodedResponse));
  } catch (e) {
    return ResponseOrderComplaints();
  }
}

Future<ResponseOrderComplaints> mockResponse(
    ParamsGetOrderComplaints params, INetworkService client) {
  return Future.value(
    ResponseOrderComplaints(claims: [
      OrderClaimHeaderModel(
        subject: "subject",
        id: 'claim_001',
        createdAt: DateTime.now(),
        fromCompanyId: 'company_123',
        toCompanyId: 'company_456',
        orderId: 'order_789',
        orderItemId: 'item_101',
        claimStatusId: 1,
      ),
      OrderClaimHeaderModel(
        id: 'claim_001',
        createdAt: DateTime.now(),
        subject: "subject",
        fromCompanyId: 'company_123',
        toCompanyId: 'company_456',
        orderId: 'order_789',
        orderItemId: 'item_101',
        claimStatusId: 1,
      ),
      OrderClaimHeaderModel(
        id: 'claim_001',
        createdAt: DateTime.now(),
        subject: "subject",
        fromCompanyId: 'company_123',
        toCompanyId: 'company_456',
        orderId: 'order_789',
        orderItemId: 'item_101',
        claimStatusId: 1,
      )
    ]),
  );
}
