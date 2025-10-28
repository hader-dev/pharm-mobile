import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_clients/cubit/clients_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/cubit/create_order_cubit.dart';
import 'package:hader_pharm_mobile/repositories/remote/clients/clients_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';

class DeligateCreateOrderStateProvider extends StatelessWidget {
  const DeligateCreateOrderStateProvider({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => DeligateCreateOrderCubit(
          parapharmaRepo: ParaPharmaRepository(
            client: getItInstance.get<INetworkService>(),
          ),
          orderRepo: OrderRepository(
            client: getItInstance.get<INetworkService>(),
          ),
          scrollController: ScrollController(),
          packageQuantityController: TextEditingController(text: "0"),
          searchController: TextEditingController(),
          quantityController: TextEditingController(text: "1"),
          customPriceController: TextEditingController(),
          shippingAddress: getItInstance.get<UserManager>().currentUser.address,
        )..getProducts(),
      ),
      BlocProvider(
        create: (context) => DeligateClientsCubit(
          clientsRepo: ClientRepository(
              client: getItInstance.get<INetworkService>(),
              userManager: getItInstance.get<UserManager>()),
          scrollController: ScrollController(),
          searchController: TextEditingController(),
        )..getClients(),
      ),
    ], child: child);
  }
}
