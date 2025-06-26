import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/features/common_features/home/home.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/orders.dart';
import 'package:hader_pharm_mobile/utils/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/routes/routing_manager.dart';
import '../common/widgets/welcoming_widget.dart';
import '../common_features/cart/cart.dart';
import '../common_features/market_place/market_place.dart';
import '../common_features/profile/profile.dart';
import 'widgets/app_nav_bar/app_nav_bar.dart';

import 'cubit/app_layout_cubit.dart';

class AppLayout extends StatelessWidget {
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
      child: BlocProvider(
        create: (context) => AppLayoutCubit(),
        child: BlocBuilder<AppLayoutCubit, AppLayoutState>(
          builder: (context, state) {
            return Scaffold(
              bottomNavigationBar: AppNavBar(),
              body: IndexedStack(
                index: BlocProvider.of<AppLayoutCubit>(context).pageIndex,
                children: screens,
              ),
            );
          },
        ),
      ),
    );
  }
}
