import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/cubit/medicine_details_cubit.dart';
import 'package:hader_pharm_mobile/repositories/remote/favorite/favorite_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/medicine_catalog/medicine_catalog_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository_impl.dart';

class StateProvider extends StatelessWidget {
  final Widget child;
  final List<String> tabs;
  final String medicineCatalogId;
  final TickerProvider vsync;

  const StateProvider(
      {super.key,
      required this.child,
      required this.tabs,
      required this.vsync,
      required this.medicineCatalogId});

  @override
  Widget build(BuildContext context) {
    final cartCubit =
        AppLayout.appLayoutScaffoldKey.currentContext!.read<CartCubit>();
    final existingCartItem = cartCubit.getItemIfExists(medicineCatalogId);

    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => MedicineDetailsCubit(
          shippingAddress: getItInstance.get<UserManager>().currentUser.address,
          packageQuantityController: TextEditingController(
              text: existingCartItem?.model.quantity.toString() ?? '1'),
          quantityController: TextEditingController(
              text: existingCartItem?.model.quantity.toString() ?? '1'),
          tabController: TabController(length: tabs.length, vsync: vsync),
          ordersRepository:
              OrderRepository(client: getItInstance.get<INetworkService>()),
          medicineCatalogRepository: MedicineCatalogRepository(
              client: getItInstance.get<INetworkService>()),
          favoriteRepository:
              FavoriteRepository(client: getItInstance.get<INetworkService>()),
        )..getMedicineCatalogData(medicineCatalogId),
      ),
      BlocProvider.value(
          value:
              AppLayout.appLayoutScaffoldKey.currentContext!.read<CartCubit>()),
    ], child: child);
  }
}
