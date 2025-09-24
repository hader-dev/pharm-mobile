import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cart.dart';
import 'package:hader_pharm_mobile/features/common_features/clients/clients.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_orders/deligate_orders.dart';
import 'package:hader_pharm_mobile/features/common_features/home/home.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/market_place.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/orders.dart';
import 'package:hader_pharm_mobile/features/common_features/profile/profile.dart';

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
      ProfileScreen(openedFrom: "")
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
    emit(CurrentUserLoaded());
  }
}
