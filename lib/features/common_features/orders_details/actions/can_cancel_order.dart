import 'package:hader_pharm_mobile/utils/enums.dart';

bool canCancelOrder(OrderStatus orderStatus) {
  return orderStatus == OrderStatus.created;
}

bool canCancelOrderByStatusId(int statusId) {
  final orderStatus = OrderStatus.values.firstWhere(
    (OrderStatus element) => element.id == statusId,
    orElse: () => OrderStatus.approved,
  );
  return canCancelOrder(orderStatus);
}
