import 'package:http/src/response.dart';

import '../../../config/services/network/network_manager.dart';
import '../../../config/services/network/network_response_handler.dart';
import '../../../models/create_order_model.dart' show CreateOrderModel;
import '../../../models/order.dart';
import '../../../models/order_details.dart';

import '../../../utils/urls.dart';
import 'order_repository.dart';

class OrderRepository extends IOrderRepository {
  final NetworkManager client;

  OrderRepository({required this.client});
  @override
  Future<(int, List<Order>)> getOrders({required int? limit, required int? offset, int? status}) async {
    final Response response = await client.sendRequest(() => client.get(Urls.order, queryParams: <String, String>{
          if (limit != null) ...<String, String>{"limit": limit.toString()},
          if (offset != null) "offset": offset.toString()
        }));

    var decodedResponse = ResponseHandler.processResponse(response);

    return (
      decodedResponse["totalItems"] as int,
      ((decodedResponse as Map)["data"] as List).map((order) => Order.fromJson(order)).toList()
    );
  }

  @override
  Future<OrderDetailsModel> getOrderById({required int orderId}) async {
    final Response response = await client.sendRequest(() => client.get(
          "${Urls.order}/$orderId",
        ));

    var decodedResponse = ResponseHandler.processResponse(response);
    return OrderDetailsModel.fromJson(decodedResponse);
  }

  @override
  Future<void> changeOrderStatus({required int orderId, required String status}) {
    // TODO: implement changeOrderStatus
    throw UnimplementedError();
  }

  @override
  Future<void> createOrder({required CreateOrderModel createOrderModel}) async {
    final Response response = await client.sendRequest(() => client.post(
          Urls.order,
          payload: createOrderModel.toJson(),
        ));
    ResponseHandler.processResponse(response);
  }
}
