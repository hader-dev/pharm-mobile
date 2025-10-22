import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_orders_details/cubit/edit/edit_order_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_orders_details/cubit/order_details/orders_details_cubit.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';

class StateProvider extends StatelessWidget {
  const StateProvider({super.key, required this.child, required this.orderId});
  final Widget child;
  final String orderId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OrderDetailsCubit(
            orderRepository: OrderRepository(
              client: getItInstance.get<INetworkService>(),
            ),
          )..getOrdersDetails(orderId: orderId),
        ),
        BlocProvider(
          create: (context) => DeligateEditOrderCubit(
            packageQuantityController: TextEditingController(text: "0"),
            parapharmaRepo: ParaPharmaRepository(
              client: getItInstance.get<INetworkService>(),
            ),
            orderRepo: OrderRepository(
              client: getItInstance.get<INetworkService>(),
            ),
            scrollController: ScrollController(),
            searchController: TextEditingController(),
            quantityController: TextEditingController(text: "1"),
            customPriceController: TextEditingController(),
          )..getProducts(),
        ),
      ],
      child: child,
    );
  }
}
