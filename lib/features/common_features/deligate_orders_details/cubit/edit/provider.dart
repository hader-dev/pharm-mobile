import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';

import 'edit_order_cubit.dart';

class DeligateEditOrderStateProvider extends StatelessWidget {
  const DeligateEditOrderStateProvider({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => DeligateEditOrderCubit(
          parapharmaRepo: ParaPharmaRepository(
            client: getItInstance.get<INetworkService>(),
          ),
          orderRepo: OrderRepository(
            client: getItInstance.get<INetworkService>(),
          ),
          scrollController: ScrollController(),
          searchController: TextEditingController(),
          packageQuantityController: TextEditingController(text: "1"),
          quantityController: TextEditingController(text: "1"),
          customPriceController: TextEditingController(),
        )..getProducts(),
      ),
    ], child: child);
  }
}
