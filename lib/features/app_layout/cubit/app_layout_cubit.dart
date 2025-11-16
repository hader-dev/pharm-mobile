import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cart.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/widgets/appbar.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_clients/clients.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_clients/widgets/appbar.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_marketplace/sub_pages/para_pharma/widget/appbar.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_orders/deligate_orders.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_orders/widgets/appbar.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_products/deligate_products.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_products/widgets/appbar.dart';
import 'package:hader_pharm_mobile/features/common_features/home/home.dart';
import 'package:hader_pharm_mobile/features/common_features/home/widgets/appbar.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/market_place.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/orders.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/widget/appbar.dart';
import 'package:hader_pharm_mobile/features/common_features/profile/profile.dart';
import 'package:hader_pharm_mobile/features/common_features/profile/widgets/appbar.dart';

part 'app_layout_state.dart';

class AppLayoutCubit extends Cubit<AppLayoutState> {
  int pageIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    MarketPlaceScreen(),
    CartScreen(),
    OrdersScreen(),
    ProfileScreen(
      openedFrom: "",
    )
  ];

  List<Widget> appTopBars = [
    const HomeAppBar(
      isExtraLargeScreen: false,
    ),
    const MarketplaceAppBar(
      isExtraLargeScreen: false,
    ),
    const CartAppBar(
      isExtraLargeScreen: false,
    ),
    const OrdersAppBar(
      isExtraLargeScreen: false,
    ),
    const ProfileAppBar(
      isExtraLargeScreen: false,
    ),
  ];

  AppLayoutCubit({required bool isExtraLargeScreen}) : super(AppLayoutInitial()) {
    UserManager.instance.currentUser.role.isDelegate
        ? deligateAppScreens(
            isExtraLargeScreen: isExtraLargeScreen,
          )
        : clientAppScreens(
            isExtraLargeScreen: isExtraLargeScreen,
          );
  }

  void changePage(int index) {
    pageIndex = index;
    emit(PageChanged());
  }

  void deligateAppScreens({required bool isExtraLargeScreen}) {
    screens = [
      ClientScreen(),
      DeligateOrdersScreen(),
      DeligateProductsScreen(),
      ProfileScreen(
        openedFrom: "",
      ),
    ];

    appTopBars = [
      DeligateClientsAppbar(
        isExtraLargeScreen: isExtraLargeScreen,
      ),
      DeligateOrdersAppbar(
        isExtraLargeScreen: isExtraLargeScreen,
      ),
      DeligateProductsAppbar(
        isExtraLargeScreen: isExtraLargeScreen,
      ),
      ProfileAppBar(
        isExtraLargeScreen: isExtraLargeScreen,
      ),
    ];
    emit(CurrentUserLoaded());
  }

  void clientAppScreens({required bool isExtraLargeScreen}) {
    screens = [
      HomeScreen(),
      MarketPlaceScreen(),
      CartScreen(),
      OrdersScreen(),
      ProfileScreen(
        openedFrom: "",
      )
    ];
    appTopBars = [
      HomeAppBar(isExtraLargeScreen: isExtraLargeScreen),
      MarketplaceAppBar(isExtraLargeScreen: isExtraLargeScreen),
      CartAppBar(isExtraLargeScreen: isExtraLargeScreen),
      OrdersAppBar(isExtraLargeScreen: isExtraLargeScreen),
      ProfileAppBar(isExtraLargeScreen: isExtraLargeScreen),
    ];
    emit(CurrentUserLoaded());
  }
}
