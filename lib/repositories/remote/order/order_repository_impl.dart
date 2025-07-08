import 'package:hader_pharm_mobile/models/create_order_model.dart';
import 'package:hader_pharm_mobile/models/create_quick_order_model.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

import '../../../config/services/network/network_interface.dart';

import '../../../models/order_details.dart';
import '../../../models/order_response.dart';
import '../../../utils/constants.dart';
import 'order_repository.dart';

class OrderRepository extends IOrderRepository {
  final INetworkService client;
  OrderRepository({required this.client});

  @override
  Future<OrderResponse> getOrders(
      {int limit = PaginationConstants.resultsPerPage, int offset = 0, String sortDirection = 'ASC'}) async {
    final queryParams = {
      'limit': limit,
      'offset': offset,
      'sort[id]': sortDirection,
    };
    var decodedResponse = await client.sendRequest(() => client.get(
          Urls.orders,
          queryParams: queryParams.map((key, value) => MapEntry(key, value.toString())),
        ));
    return OrderResponse.fromJson(decodedResponse);
  }

  @override
  Future<OrderDetailsModel> getMOrderById(String id) async {
    var decodedResponse = await client.sendRequest(() => client.get("${Urls.orders}/$id"));
    return OrderDetailsModel.fromJson(decodedResponse);
  }

  @override
  Future<void> createOrder({required CreateOrderModel orderDetails}) async {
    await client.sendRequest(() => client.post(
          Urls.orders,
          payload: orderDetails.toJson(),
        ));
  }

  @override
  Future<void> createQuickOrder({required CreateQuickOrderModel orderDetails}) async {
    await client.sendRequest(() => client.post(
          Urls.buyNow,
          payload: orderDetails.toJson(),
        ));
  }
}
