import '../../../models/create_order_model.dart';
import '../../../models/order.dart';
import '../../../models/order_details.dart';

abstract class IOrderRepository {
  Future<(int, List<Order>)> getOrders({required int limit, required int offset, int? status});
  Future<OrderDetailsModel> getOrderById({required int orderId});
  Future<void> changeOrderStatus({required int orderId, required String status});
  Future<void> createOrder({required CreateOrderModel createOrderModel});
}
