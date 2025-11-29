import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/notification/actions/handle_terminated_app_notification_tab.dart'
    show handleTerminatedAppNotificationTab;
import 'package:hader_pharm_mobile/config/theme/setup_status_bar.dart';
import 'package:hader_pharm_mobile/features/app_layout/actions/show_new_app_version_dialog.dart';
import 'package:hader_pharm_mobile/features/app_layout/actions/show_welcome_dialog.dart';
import 'package:hader_pharm_mobile/features/app_layout/cubit/app_state_provider.dart';
import 'package:hader_pharm_mobile/utils/env_helper.dart';

import 'cubit/app_layout_cubit.dart';
import 'widgets/app_nav_bar/app_nav_bar.dart';

class AppLayout extends StatefulWidget {
  static final GlobalKey<ScaffoldState> appLayoutScaffoldKey =
      GlobalKey<ScaffoldState>();

  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  @override
  void initState() {
    super.initState();
    handleTerminatedAppNotificationTab();
  }

  @override
  Widget build(BuildContext context) {
    Future.microtask(() => showWelcomingDialog());

    if (EnvHelper.getFeatureFlag(EnvHelper.featureFlagUpdatePopup) == true) {
      Future.microtask(() => showNewAppVersionDialog());
    }

    setupStatusBar();

    final app = BlocBuilder<AppLayoutCubit, AppLayoutState>(
      builder: (context, state) {
        return Scaffold(
          key: AppLayout.appLayoutScaffoldKey,
          bottomNavigationBar: AppNavBar(),
          body: SafeArea(
            child: Column(
              children: [
                BlocProvider.of<AppLayoutCubit>(context).appTopBars[
                    BlocProvider.of<AppLayoutCubit>(context).pageIndex],
                Expanded(
                  child: IndexedStack(
                    index: BlocProvider.of<AppLayoutCubit>(context).pageIndex,
                    children: BlocProvider.of<AppLayoutCubit>(context).screens,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    return UserManager.instance.currentUser.role.isDelegate
        ? AppStateDeligateProvider(child: app)
        : AppStateProvider(child: app);
  }
}
