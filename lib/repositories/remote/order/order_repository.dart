import 'package:hader_pharm_mobile/models/create_order_model.dart';
import 'package:hader_pharm_mobile/models/create_quick_order_model.dart';
import 'package:hader_pharm_mobile/models/order_details.dart';
import 'package:hader_pharm_mobile/models/order_response.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/cancel_order.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/item_complaint.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/order_complaint.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_item_complaint_find.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_item_complaint_make.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_order_cancel.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/response_order_complaints.dart';

abstract class IOrderRepository {
  Future<OrderResponse> getOrders({
    int limit = 8,
    int offset = 0,
    String sortDirection = 'ASC',
  });
  Future<OrderDetailsModel> getMOrderById(String id);
  Future<void> createOrder({required CreateOrderModel orderDetails});
  Future<void> createQuickOrder({required CreateQuickOrderModel orderDetails});

  Future<ResponseOrderCancel> cancelOrder(ParamsCancelOrder params);

  Future<ResponseItemComplaintMake> makeComplaint(ParamsMakeComplaint params);

  Future<ResponseItemComplaintFind> findComplaint(ParamsGetComplaint params);

  Future<ResponseOrderComplaints> getOrderClaims(ParamsGetOrderComplaints params);
}
