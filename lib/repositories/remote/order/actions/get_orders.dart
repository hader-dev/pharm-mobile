import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/order_response.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<OrderResponse> getOrders(
    Map<String, String> queryParams, INetworkService client) async {
  var decodedResponse = await client.sendRequest(() => client.get(
        Urls.orders,
        queryParams: queryParams,
      ));
  return OrderResponse.fromJson(decodedResponse);
}
