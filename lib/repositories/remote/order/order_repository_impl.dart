import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/create_order_model.dart';
import 'package:hader_pharm_mobile/models/create_quick_order_model.dart';
import 'package:hader_pharm_mobile/models/order_details.dart';
import 'package:hader_pharm_mobile/models/order_response.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/item_complaint.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/order_complaint.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_item_complaint_find.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_item_complaint_make.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_order_cancel.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_order_complaints.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

import 'order_repository.dart';
import 'actions/cancel_order.dart' as actions;
import 'actions/create_quick_order.dart' as actions;
import 'actions/create_order.dart' as actions;
import 'actions/get_more_order.dart' as actions;
import 'actions/get_orders.dart' as actions;
import 'actions/find_complaint.dart' as find_complaint_action;
import 'actions/make_complaint.dart' as make_complaint_action;
import 'actions/order_complaint.dart' as order_complaint_action;


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
      if (statusesFilter.isNotEmpty)
        'in[status][]': statusesFilter
            .map((status) => status.toString())
            .toList()
            .join(','),
      if (minPriceFilter != null)
        'gte[totalAmountTtc]': minPriceFilter.toStringAsFixed(2),
      if (maxPriceFilter != null)
        'lte[totalAmountTtc]': maxPriceFilter.toStringAsFixed(2),
      if (initialDateFilter != null) 'date[createdAt][from]': initialDateFilter,
      if (finalDateFilter != null) 'date[createdAt][to]': finalDateFilter,
    };

    return actions.getOrders(queryParams, client);
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
  Future<void> createQuickOrder(
      {required CreateQuickOrderModel orderDetails}) async {
    return actions.createQuickOrder(orderDetails, client);
  }

  @override
  Future<ResponseOrderCancel> cancelOrder(params) {
    return actions.cancelOrder(params, client);
  }

  @override

  Future<ResponseItemComplaintFind> findComplaint(ParamsGetComplaint params) {
// TODO: switch to api when it's implemented ready
    return find_complaint_action.mockResponse(params, client);
  }

  @override
  Future<ResponseItemComplaintMake> makeComplaint(ParamsMakeComplaint params) {
// TODO: switch to api when it's implemented ready
    return make_complaint_action.mockResponse(params, client);
  }

  @override
  Future<ResponseOrderComplaints> getOrderClaims(ParamsGetOrderComplaints params) {
// TODO: switch to api when it's implemented ready
    return order_complaint_action.mockResponse(params, client);
  }
}
