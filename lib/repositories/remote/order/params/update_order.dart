import 'package:hader_pharm_mobile/models/order_change.dart';

class ParamsUpdateOrder {
  final List<OrderItemDelete> deleteOrderItems;
  final List<OrderItemChange> updateOrderItems;
  final List<OrderItemAdd> addOrderItems;
  final String orderId;

  ParamsUpdateOrder(
      {required this.deleteOrderItems,
      required this.updateOrderItems,
      required this.orderId,
      required this.addOrderItems});

  Map<String, dynamic> toJson() {
    return {
      'deleteOrderItemsIds': deleteOrderItems.map((el) => el.id).toList(),
      'updateOrderItems': updateOrderItems.map((el) => el.toJson()).toList(),
      'addOrderItems': addOrderItems.map((el) => el.toJson()).toList(),
    };
  }
}
