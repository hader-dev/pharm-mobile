import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/order_claim.dart';
import 'package:hader_pharm_mobile/models/order_details.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/mappers/json_to_order_claim_model.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/mappers/params_make_complaint_to_json.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/item_complaint.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_item_complaint_make.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<ResponseItemComplaintMake> makeComplaint(ParamsMakeComplaint params, INetworkService client) async {
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
