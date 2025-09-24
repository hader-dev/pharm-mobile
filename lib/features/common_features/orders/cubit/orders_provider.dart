import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/cubit/orders_cubit.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository_impl.dart';

class OrdersProviderState extends StatelessWidget {
  final Widget child;
  const OrdersProviderState({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => OrdersCubit(
            orderRepository:
                OrderRepository(client: getItInstance.get<INetworkService>()),
            scrollController: ScrollController())
          ..getOrders(),
        child: child);
  }
}
