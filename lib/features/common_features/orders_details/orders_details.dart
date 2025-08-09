import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocProvider, MultiBlocProvider;
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/widgets/tabs_section.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository_impl.dart';
import 'cubit/orders_details_cubit.dart';
import 'widgets/order_details_appbar.dart';

class OrdersDetailsScreen extends StatelessWidget {
  final String orderId;
  static final GlobalKey<ScaffoldState> ordersDetailsScaffoldKey =
      GlobalKey<ScaffoldState>();
  const OrdersDetailsScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => OrderDetailsCubit(
              orderRepository: OrderRepository(
                client: getItInstance.get<INetworkService>(),
              ),
            )..getOrdersDetails(orderId: orderId),
          ),
        ],
        child: Scaffold(
          key: ordersDetailsScaffoldKey,
          appBar: OrderDetailsAppbar(),
          body: OrderDetailsTabBarSection(orderId: orderId),
        ),
      ),
    );
  }
}
