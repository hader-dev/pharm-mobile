import 'package:hader_pharm_mobile/models/order_response.dart';

import '../../../models/create_order_model.dart';
import '../../../models/create_quick_order_model.dart';
import '../../../models/order_details.dart';

abstract class IOrderRepository {
  Future<OrderResponse> getOrders({
    int limit = 8,
    int offset = 0,
    String sortDirection = 'ASC',
  });
  Future<OrderDetailsModel> getMOrderById(String id);
  Future<void> createOrder({required CreateOrderModel orderDetails});
  Future<void> createQuickOrder({required CreateQuickOrderModel orderDetails});
}
