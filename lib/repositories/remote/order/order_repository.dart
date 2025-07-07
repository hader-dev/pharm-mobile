import 'package:hader_pharm_mobile/models/order_response.dart';

import '../../../models/order_details.dart';

abstract class IOrderRepository {
  Future<OrderResponse> getOrders({
    int limit = 8,
    int offset = 0,
    String sortDirection = 'ASC',
  });
  Future<OrderDetailsModel> getMOrderById(String id);
  Future<void> createOrder(List<String> cartItemsIds);
}
