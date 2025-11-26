import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/cubit/provider.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/widgets/tabs_section.dart';

import 'widgets/order_details_appbar.dart';

class OrdersDetailsScreen extends StatelessWidget {
  final String orderId;
  static final GlobalKey<ScaffoldState> ordersDetailsScaffoldKey = GlobalKey<ScaffoldState>();
  const OrdersDetailsScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return StateProvider(
      orderId: orderId,
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (!didPop) {
            if (context.canPop()) {
              context.pop(result);
              return;
            }
            RoutingManager.router.pushReplacementNamed(RoutingManager.appLayout);
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          key: ordersDetailsScaffoldKey,
          appBar: OrderDetailsAppBar(),
          body: SafeArea(
            child: OrderDetailsTabBarSection(orderId: orderId),
          ),
        ),
      ),
    );
  }
}
