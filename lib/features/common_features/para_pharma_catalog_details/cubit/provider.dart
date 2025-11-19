import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/cubit/para_pharma_details_cubit.dart';
import 'package:hader_pharm_mobile/repositories/remote/favorite/favorite_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';

class StateProvider extends StatelessWidget {
  final Widget child;
  final List<String> tabs;
  final String catalogId;
  final TickerProvider vsync;
  final bool needCartCubit;

  const StateProvider(
      {super.key,
      required this.child,
      required this.tabs,
      required this.needCartCubit,
      required this.vsync,
      required this.catalogId});

  @override
  Widget build(BuildContext context) {
    final cartCubit = needCartCubit ? AppLayout.appLayoutScaffoldKey.currentContext?.read<CartCubit>() : null;
    final existingCartItem = cartCubit?.getItemIfExists(catalogId);

    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => ParaPharmaDetailsCubit(
            packageQuantityController: TextEditingController(text: existingCartItem?.model.quantity.toString() ?? '0'),
            quantityController: TextEditingController(text: existingCartItem?.model.quantity.toString() ?? '1'),
            tabController: TabController(length: tabs.length, vsync: vsync),
            ordersRepository: OrderRepository(client: getItInstance.get<INetworkService>()),
            paraPharmaCatalogRepository: ParaPharmaRepository(client: getItInstance.get<INetworkService>()),
            favoriteRepository: FavoriteRepository(client: getItInstance.get<INetworkService>()))
          ..getParaPharmaCatalogData(catalogId),
      ),
      if (cartCubit != null) BlocProvider.value(value: cartCubit),
    ], child: child);
  }
}
