import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/create_order_model.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<void> createOrder(CreateOrderModel orderDetails, INetworkService client) async {
  return await client.sendRequest(() => client.post(
        Urls.orders,
        payload: orderDetails,
      ));
}
