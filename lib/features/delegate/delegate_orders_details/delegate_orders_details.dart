import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_orders_details/cubit/order_details/orders_details_cubit.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_orders_details/widgets/tabs_section.dart';

import '../../../utils/enums.dart' show OrderStatus;
import 'cubit/provider.dart' show StateProvider;
import 'widgets/order_details_appbar.dart';

class DelegateOrdersDetailsScreen extends StatelessWidget {
  final String orderId;
  static final GlobalKey<ScaffoldState> delegateOrdersDetailsScaffoldKey = GlobalKey<ScaffoldState>();
  const DelegateOrdersDetailsScreen({super.key, required this.orderId});

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
          key: delegateOrdersDetailsScaffoldKey,
          appBar: DelegateOrderDetailsAppBar(),
          body: SafeArea(
            child: BlocBuilder<DelegateOrderDetails2Cubit, DelegateOrdersDetails2State>(
              builder: (context, state) {
                return DelegateOrderDetailsTabBarSection(
                  orderId: orderId,
                  isEditable: state.orderData.status == OrderStatus.created.id,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
