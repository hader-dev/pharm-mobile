import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/cancel_order.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_order_cancel.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<ResponseOrderCancel> cancelOrder(
    ParamsCancelOrder params, INetworkService client) async {
  try {
    await client
        .sendRequest(() => client.patch("${Urls.orders}/${params.id}/status/canceled"));
  } catch (e) {
    
    return ResponseOrderCancel(statusCode: 400,success: false);
  }

  return ResponseOrderCancel();
}
