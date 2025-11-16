import 'package:flutter/cupertino.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/order_claim.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/mappers/json_to_order_complaint_response.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/order_complaint.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_order_complaints.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<ResponseOrderComplaints> getOrderComplaints(ParamsGetOrderComplaints params, INetworkService client) async {
  final queryParams = {"filters[orderId]": params.orderId};

  try {
    var decodedResponse = await client.sendRequest(() => client.get(Urls.complaints, queryParams: queryParams));
    return jsonToOrderComplaintResponse(decodedResponse);
  } catch (e, stackTrace) {
    debugPrintStack(stackTrace: stackTrace);
    debugPrint("$e");
    return ResponseOrderComplaints();
  }
}
