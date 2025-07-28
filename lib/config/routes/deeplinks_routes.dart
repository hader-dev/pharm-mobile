import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/orders_details.dart';

abstract class DeeplinksRoutes {
  static const String deepLinkOrderDetails = '/order';

                  


  static final deppLinkRoutes = [
    GoRoute(
      name: deepLinkOrderDetails,
      path: deepLinkOrderDetails,
      builder: (BuildContext context, GoRouterState state) {

        final orderId = (state.uri.queryParameters['orderId'] ?? state.extra) as String;
        return OrdersDetailsScreen(
          orderId: orderId ,
        );
      },
    ),
  ];
}
