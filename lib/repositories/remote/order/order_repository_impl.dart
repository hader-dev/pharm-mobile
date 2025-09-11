import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/create_order_model.dart';
import 'package:hader_pharm_mobile/models/create_quick_order_model.dart';
import 'package:hader_pharm_mobile/models/order_details.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/invoice.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/item_complaint.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/order_complaint.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/invoice_response.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/order_response.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_item_complaint_find.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_item_complaint_make.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_order_cancel.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_order_complaints.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

import 'actions/cancel_order.dart' as actions;
import 'actions/create_order.dart' as actions;
import 'actions/create_quick_order.dart' as actions;
import 'actions/find_complaint.dart' as find_complaint_action;
import 'actions/get_invoice.dart' as invoice_action;
import 'actions/get_more_order.dart' as actions;
import 'actions/get_orders.dart' as actions;
import 'actions/make_complaint.dart' as make_complaint_action;
import 'actions/order_complaint.dart' as order_complaint_action;
import 'order_repository.dart';

class OrderRepository extends IOrderRepository {
  final INetworkService client;
  OrderRepository({required this.client});

  @override
  Future<OrderResponse> getOrders({
    int limit = PaginationConstants.resultsPerPage,
    int offset = 0,
    String sortDirection = 'DESC',
  }) async {
    final Map<String, String> queryParams = {
      'limit': limit.toString(),
      'offset': offset.toString(),
      'sort[id]': sortDirection,
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
    return find_complaint_action.findComplaint(params, client);
  }

  @override
  Future<ResponseItemComplaintMake> makeComplaint(ParamsMakeComplaint params) {
    return make_complaint_action.makeComplaint(params, client);
  }

  @override
  Future<ResponseOrderComplaints> getOrderClaims(
      ParamsGetOrderComplaints params) {
    return order_complaint_action.getOrderComplaints(params, client);
  }

  @override
  Future<ResponseInvoice> invoiceDetails(ParamsGetInvoice params) {
    return invoice_action.getMockInvoiceDetaills(params, client);
  }
}
