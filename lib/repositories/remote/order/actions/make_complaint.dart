import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/order_claim.dart';
import 'package:hader_pharm_mobile/models/order_details.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/mappers/json_to_order_claim_model.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/mappers/params_make_complaint_to_json.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/item_complaint.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_item_complaint_make.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<ResponseItemComplaintMake> makeComplaint(
    ParamsMakeComplaint params, INetworkService client) async {
  try {
    var res = await client.sendRequest(() => client.post(
          Urls.complaints,
          payload: paramsMakeComplaintToJson(params),
        ));

    var decodedResponse = jsonToOrderClaimModel(res);

    return ResponseItemComplaintMake(orderClaimModel: decodedResponse);
  } catch (e) {
    return ResponseItemComplaintMake();
  }
}

Future<ResponseItemComplaintMake> mockResponse(
    ParamsMakeComplaint params, INetworkService client) {
  return Future.value(
    ResponseItemComplaintMake(
        orderClaimModel: OrderClaimModel(
          id: "1",
          fromCompanyId: "101",
          toCompanyId: "202",
          orderId: "303",
          orderItemId: "404",
          claimStatusId: 1,
          subject: "Damaged Item",
          description:
              "The product arrived with a broken seal and visible dents.",
        ),
        orderItemModel: OrderItem(
          id: "item-001",
          totalAmountTtc: 120.50,
          totalAmountHt: 100.42,
          tvaPercentage: 20.0,
          unitPriceHt: 50.21,
          unitPriceTtc: 60.25,
          createdAt: DateTime.now().subtract(const Duration(days: 5)),
          updatedAt: DateTime.now(),
          medicineCatalogId: "med-12345",
          parapharmCatalogId: null,
          quantity: 2,
          designation: "Paracetamol 500mg",
          lotNumber: "LOT123456",
          expirationDate: DateTime.now().add(const Duration(days: 365)),
          margin: 15.0,
          discountAmount: 5.0,
          orderId: "order-789",
          imageUrl: "https://via.placeholder.com/150",
          note: "Urgent delivery",
        ),
        claimStatusHistory: [
          ClaimStatusHistoryModel(
            claimStatusId: 1,
            id: "1001",
            calimId: "5001",
            note: "Complaint received",
            createdAt: DateTime.now().subtract(const Duration(days: 5)),
            updatedByUserId: "42",
          ),
          ClaimStatusHistoryModel(
            claimStatusId: 2,
            id: "1002",
            calimId: "5001",
            note: "Investigation started",
            createdAt: DateTime.now().subtract(const Duration(days: 3)),
            updatedByUserId: "101",
          ),
          ClaimStatusHistoryModel(
            claimStatusId: 3,
            id: "1003",
            calimId: "5001",
            note: "Resolved with partial refund",
            createdAt: DateTime.now().subtract(const Duration(days: 1)),
            updatedByUserId: "42",
          ),
        ]),
  );
}
