import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';

void handleOrderDeepLink(Uri uri) {
  final router = RoutingManager.router;
  final orderId =
      uri.queryParameters["orderId"] ?? uri.queryParameters["orderid"];

  router.push(RoutingManager.ordersDetailsScreen, extra: orderId);
}
