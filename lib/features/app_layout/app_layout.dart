import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/features/app_layout/actions/show_new_app_version_dialog.dart';
import 'package:hader_pharm_mobile/features/app_layout/actions/show_welcome_dialog.dart';
import 'package:hader_pharm_mobile/features/app_layout/cubit/app_state_provider.dart';

import 'cubit/app_layout_cubit.dart';
import 'widgets/app_nav_bar/app_nav_bar.dart';

class AppLayout extends StatelessWidget {
  static final GlobalKey<ScaffoldState> appLayoutScaffoldKey =
      GlobalKey<ScaffoldState>();

  const AppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() => showWelcomingDialog());
    Future.microtask(() => showNewAppVersionDialog());

    final app = BlocBuilder<AppLayoutCubit, AppLayoutState>(
      builder: (context, state) {
        return Scaffold(
          key: appLayoutScaffoldKey,
          bottomNavigationBar: AppNavBar(),
          body: IndexedStack(
            index: BlocProvider.of<AppLayoutCubit>(context).pageIndex,
            children: BlocProvider.of<AppLayoutCubit>(context).screens,
          ),
        );
      },
    );

    return SafeArea(
      child: UserManager.instance.currentUser.role.isDelegate
          ? AppStateDeligateProvider(child: app)
          : AppStateProvider(child: app),
    );
  }
}
