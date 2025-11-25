import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/cancel_order.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_order_cancel.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<ResponseOrderCancel> cancelOrder(ParamsCancelOrder params, INetworkService client) async {
  try {
    var decodedResponse = await client.sendRequest(() => client.patch("${Urls.orders}/status/cancelled", payload: [
          {
            "orderId": params.id,
            if (params.reason != null && params.reason!.isNotEmpty) ...{"note": params.reason}
          }
        ]));
    if ((decodedResponse["success"] as List).isNotEmpty) {
      return ResponseOrderCancel(statusCode: 200, success: true);
    } else {
      return ResponseOrderCancel(statusCode: 400, success: false);
    }
  } catch (e) {
    return ResponseOrderCancel(statusCode: 400, success: false);
  }
}
