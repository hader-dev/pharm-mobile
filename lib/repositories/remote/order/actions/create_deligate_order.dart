import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<void> createDeligateOrder({
  required Map<String, dynamic> orderData,
  required INetworkService client,
}) async {
  return await client.sendRequest(() => client.post(
        '${Urls.orders}/deligate',
        payload: orderData,
      ));
}
