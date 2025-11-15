import 'package:flutter/foundation.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/order_claim.dart';
import 'package:hader_pharm_mobile/models/order_details.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/mappers/json_to_order_claim_model.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/item_complaint.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_item_complaint_find.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<ResponseItemComplaintFind> findComplaint(ParamsGetComplaint params, INetworkService client) async {
  try {
    if (params.complaintId.isEmpty) {
      return ResponseItemComplaintFind();
    }
    var decodedResponse = await client.sendRequest(() => client.get(
          Urls.itemComplaint(params.complaintId),
        ));

    return ResponseItemComplaintFind(
        orderClaimModel: jsonToOrderClaimModel(decodedResponse),
        claimStatusHistory: jsonToOrderClaimStatusHistoryList(decodedResponse["complaintStatusHistory"] ?? []));
  } catch (e, stackTrace) {
    debugPrint("$e");
    debugPrintStack(stackTrace: stackTrace);
    return ResponseItemComplaintFind();
  }
}
