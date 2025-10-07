import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/update_order.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/update_order.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<ResponseUpdateOrder> updateOrder(
    ParamsUpdateOrder params, INetworkService client) async {
  try {
    debugPrint("Sendin ${params.toJson()}");
    await client.sendRequest(() => client
        .patch("${Urls.orders}/${params.orderId}", payload: params.toJson()));
  } catch (e) {
    debugPrint("Order update error: $e");
    return ResponseUpdateOrder(affectedRows: 0);
  }

  return ResponseUpdateOrder(affectedRows: 1);
}
