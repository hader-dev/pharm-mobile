import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/update_order_item.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/update_order_item.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<ResponseUpdateOrderItem> updateOrderItem(
    ParamsUpdateOrderItem params, INetworkService client) async {
  try {
    await client.sendRequest(() => client
        .patch("${Urls.orders}/${params.orderId}", payload: params.toJson()));
  } catch (e) {
    return ResponseUpdateOrderItem();
  }

  return ResponseUpdateOrderItem();
}
