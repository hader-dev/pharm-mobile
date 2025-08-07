import 'package:hader_pharm_mobile/models/create_order_model.dart';
import 'package:hader_pharm_mobile/models/create_quick_order_model.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_order_cancel.dart';

import '../../../config/services/network/network_interface.dart';

import '../../../models/order_details.dart';
import '../../../models/order_response.dart';
import '../../../utils/constants.dart';

import 'order_repository.dart';
import 'actions/cancel_order.dart' as actions;
import 'actions/create_quick_order.dart' as actions;
import 'actions/create_order.dart' as actions;
import 'actions/get_more_order.dart' as actions;
import 'actions/get_orders.dart' as actions;




class OrderRepository extends IOrderRepository {
  final INetworkService client;
  OrderRepository({required this.client});

  @override
  Future<OrderResponse> getOrders({
    int limit = PaginationConstants.resultsPerPage,
    int offset = 0,
    String sortDirection = 'ASC',
    List<int> statusesFilter = const [],
    double? minPriceFilter,
    double? maxPriceFilter,
    String? initialDateFilter,
    String? finalDateFilter,
  }) async {

    final Map<String, String> queryParams = {
      'limit': limit.toString(),
      'offset': offset.toString(),
      'sort[id]': sortDirection,
      if (statusesFilter.isNotEmpty) 'in[status][]': statusesFilter.map((status) => status.toString()).toList().join(','),
      if (minPriceFilter != null) 'gte[totalAmountTtc]': minPriceFilter.toStringAsFixed(2),
      if (maxPriceFilter != null) 'lte[totalAmountTtc]': maxPriceFilter.toStringAsFixed(2),
      if (initialDateFilter != null) 'date[createdAt][from]': initialDateFilter,
      if (finalDateFilter != null) 'date[createdAt][to]': finalDateFilter,
    };
  
    return actions.getOrders(queryParams,client);
  }

  @override
  Future<OrderDetailsModel> getMOrderById(String id) async {
    return actions.getMoreOrderById(id, client);
  }

  @override
  Future<void> createOrder({required CreateOrderModel orderDetails}) async {
    return actions.createOrder(orderDetails, client);
  }

  @override
  Future<void> createQuickOrder({required CreateQuickOrderModel orderDetails}) async {
   return actions.createQuickOrder(orderDetails, client);
  }
  
  @override
  Future<ResponseOrderCancel> cancelOrder(params) {
    return actions.cancelOrder(params, client);
  }

}
