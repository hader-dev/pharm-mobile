import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/order_details.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<OrderDetailsModel> getMoreOrderById(
    String id, INetworkService client) async {
  var decodedResponse =
      await client.sendRequest(() => client.get("${Urls.orders}/$id"));
  return OrderDetailsModel.fromJson(decodedResponse);
}
