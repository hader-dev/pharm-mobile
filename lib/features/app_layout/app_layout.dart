import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/home/home.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/orders.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/routes/routing_manager.dart';
import '../../config/services/network/network_interface.dart';
import '../../repositories/remote/cart_items/cart_items_repository_impl.dart';
import '../../utils/toast_helper.dart';
import '../common/widgets/welcoming_widget.dart';
import '../common_features/cart/cart.dart';
import '../common_features/market_place/market_place.dart';
import '../common_features/profile/profile.dart';
import 'widgets/app_nav_bar/app_nav_bar.dart';

import 'cubit/app_layout_cubit.dart';

class AppLayout extends StatelessWidget {
  static final GlobalKey<ScaffoldState> appLayoutScaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> screens = const [
    HomeScreen(),
    MarketPlaceScreen(),
    CartScreen(),
    OrdersScreen(),
    ProfileScreen(
      openedFrom: "",
    )
  ];
  const AppLayout({super.key});

  void showWelcomingDialog() {
    if (getItInstance.get<SharedPreferences>().getBool(SPKeys.isFirstLoggin) ?? true) {
      Future.delayed(Duration(milliseconds: 400), () {
        showDialog(
            context: RoutingManager.rootNavigatorKey.currentContext!,
            builder: (context) => Dialog(clipBehavior: Clip.antiAlias, child: WelcomingWidget()));
      });
      getItInstance.get<SharedPreferences>().setBool(SPKeys.isFirstLoggin, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.microtask(() => showWelcomingDialog());
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppLayoutCubit(),
          ),
          BlocProvider(
            create: (context) => CartCubit(CartItemRepository(client: getItInstance.get<INetworkService>()),
                ScrollController(), OrderRepository(client: getItInstance.get<INetworkService>()))
              ..getCartItem(),
          ),
        ],
        child: BlocListener<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartItemAdded) {
              getItInstance.get<ToastManager>().showToast(type: ToastType.success, message: 'Item added to cart');
            }
          },
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return BlocBuilder<AppLayoutCubit, AppLayoutState>(
                builder: (context, state) {
                  return Scaffold(
                    key: appLayoutScaffoldKey,
                    bottomNavigationBar: AppNavBar(),
                    body: IndexedStack(
                      index: BlocProvider.of<AppLayoutCubit>(context).pageIndex,
                      children: screens,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
