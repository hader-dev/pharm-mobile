import 'package:hader_pharm_mobile/models/order_response.dart';

import '../../../models/medicine_catalog.dart';

abstract class IOrderRepository {
  Future<OrderResponse> getOrders({
    int limit = 8,
    int offset = 0,
    String sortDirection = 'ASC',
  });
  Future<MedicineCatalogModel> getMOrderById(String id);
}
