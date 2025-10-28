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

  List<PreferredSizeWidget> navbars = [
    const HomeAppbar(),
    const MarketplaceAppbar(),
    const CartAppbar(),
    const OrdersAppbar(),
    const ProfileAppbar(),
  ];

  AppLayoutCubit() : super(AppLayoutInitial()) {
    UserManager.instance.currentUser.role.isDelegate
        ? deligateAppScreens()
        : clientAppScreens();
  }

  void changePage(int index) {
    pageIndex = index;
    emit(PageChanged());
  }

  void deligateAppScreens() {
    screens = [
      ClientScreen(),
      DeligateOrdersScreen(),
      DeligateProductsScreen(),
      ProfileScreen(openedFrom: "")
    ];

    navbars = [
      const DeligateClientsAppbar(),
      const DeligateOrdersAppbar(),
      const DeligateProductsAppbar(),
      const ProfileAppbar(),
    ];
    emit(CurrentUserLoaded());
  }

  void clientAppScreens() {
    screens = [
      HomeScreen(),
      MarketPlaceScreen(),
      CartScreen(),
      OrdersScreen(),
      ProfileScreen(
        openedFrom: "",
      )
    ];
    navbars = [
      const HomeAppbar(),
      const MarketplaceAppbar(),
      const CartAppbar(),
      const OrdersAppbar(),
      const ProfileAppbar(),
    ];
    emit(CurrentUserLoaded());
  }
}
