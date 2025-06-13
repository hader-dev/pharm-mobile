import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/home/home.dart';

import '../market_place/market_place.dart';
import 'widgets/app_nav_bar/app_nav_bar.dart';

import 'cubit/app_layout_cubit.dart';

class AppLayout extends StatelessWidget {
  final List<Widget> screens = const [HomeScreen(), MarketPlaceScreen(), HomeScreen(), HomeScreen(), HomeScreen()];
  const AppLayout({super.key});

  @override
  Widget build(BuildContext context) {
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
