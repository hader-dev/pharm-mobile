import 'dart:convert' show jsonEncode;

import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/get_orders.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/order_response.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<OrderResponse> getOrders(ParamsGetOrder params, INetworkService client) async {
  final Map<String, Object> queryParams = {
    'limit': params.limit.toString(),
    'offset': params.offset.toString(),
    'sort[id]': params.sortDirection,
    "include[clientCompany][fields][]": ['name'],
    "include[sellerCompany][fields][]": ['name'],
    if (params.searchQuery != null && params.searchQuery!.isNotEmpty) 'search[displayId]': params.searchQuery!,
  };

  if (params.filters.status.isNotEmpty) {
    final statusIds = params.filters.status
        .map(
          (s) => OrderStatus.values
              .firstWhere(
                (e) => e.name.toLowerCase() == s.toLowerCase(),
                orElse: () => OrderStatus.created,
              )
              .id
              .toString(),
        )
        .toList();

    queryParams['filters[status]'] = statusIds;
  }

  if (params.filters.createdAtFrom.isNotEmpty) {
    queryParams['date[createdAt][from]'] = params.filters.createdAtFrom.first;
  }

  if (params.filters.createdAtTo.isNotEmpty) {
    queryParams['date[createdAt][to]'] = params.filters.createdAtTo.first;
  }

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
