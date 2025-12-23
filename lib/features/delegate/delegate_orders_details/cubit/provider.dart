import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository_impl.dart';

import 'order_details/orders_details_cubit.dart' show DelegateOrderDetails2Cubit;

class StateProvider extends StatelessWidget {
  const StateProvider({super.key, required this.child, required this.orderId});
  final Widget child;
  final String orderId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DelegateOrderDetails2Cubit(
            orderRepository: OrderRepository(
              client: getItInstance.get<INetworkService>(),
            ),
          )..getOrdersDetails(orderId: orderId),
        ),
      ],
      child: child,
    );
  }
}
