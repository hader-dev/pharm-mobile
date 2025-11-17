import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/delete_order_item.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/delete_order_item.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<ResponseDeleteOrderItem> deleteOrderItem(ParamsDeleteOrderItem params, INetworkService client) async {
  try {
    await client.sendRequest(() => client.patch("${Urls.orders}/${params.orderId}", payload: params));
  } catch (e) {
    return ResponseDeleteOrderItem();
  }

  return ResponseDeleteOrderItem();
}
