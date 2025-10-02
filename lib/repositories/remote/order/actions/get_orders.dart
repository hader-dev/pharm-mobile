import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/order.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/get_orders.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/order_response.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<OrderResponse> getOrders(
    ParamsGetOrder params, INetworkService client) async {
  final Map<String, String> queryParams = {
    'limit': params.limit.toString(),
    'offset': params.offset.toString(),
    'sort[id]': params.sortDirection,
    if (params.searchQuery != null) 'search[displayId]': params.searchQuery!,
  };

  try {
    var decodedResponse = await client.sendRequest(
      () => client.get(
        Urls.orders,
        queryParams: queryParams,
      ),
    );

    return OrderResponse.fromJson(decodedResponse);
  } catch (e, stack) {
    debugPrint("$e");
    debugPrintStack(stackTrace: stack);
    return OrderResponse(totalItems: 0, data: []);
  }
}

Future<OrderResponse> getMockOrders(
    Map<String, String> queryParams, INetworkService client) async {
  return OrderResponse(totalItems: 2, data: [
    BaseOrderModel.mock(),
    BaseOrderModel.mock(),
  ]);
}
