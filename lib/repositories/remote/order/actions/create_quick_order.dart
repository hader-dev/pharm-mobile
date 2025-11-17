import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/create_quick_order_model.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

void createQuickOrder(CreateQuickOrderModel orderDetails, INetworkService client) async {
  await client.sendRequest(() => client.post(
        Urls.buyNow,
        payload: orderDetails,
      ));
}
