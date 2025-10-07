import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_orders_details/cubit/order_details/provider.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_orders_details/widgets/tabs_section.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';

import 'cubit/order_details/orders_details_cubit.dart';
import 'widgets/order_details_appbar.dart';

class DeligateOrdersDetailsScreen extends StatelessWidget {
  final String orderId;
  static final GlobalKey<ScaffoldState> deligateOrdersDetailsScaffoldKey =
      GlobalKey<ScaffoldState>();
  const DeligateOrdersDetailsScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StateProvider(
        orderId: orderId,
        child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (!didPop) {
              if (context.canPop()) {
                context.pop(result);
                return;
              }
              RoutingManager.router
                  .pushReplacementNamed(RoutingManager.appLayout);
            }
          },
          child: Scaffold(
            key: deligateOrdersDetailsScaffoldKey,
            appBar: OrderDetailsAppbar(),
            body: BlocBuilder<OrderDetailsCubit, OrdersDetailsState>(
                builder: (context, state) {
              return OrderDetailsTabBarSection(
                orderId: orderId,
                isEditable: state.orderData.status == OrderStatus.created.id,
              );
            }),
          ),
        ),
      ),
    );
  }
}
