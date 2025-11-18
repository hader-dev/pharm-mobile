import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common_features/notification/cubit/notifications_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/notification/view/notification_list.dart';
import 'package:hader_pharm_mobile/features/common_features/notification/widgets/notification_appbar.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class NotificaitonScreen extends StatelessWidget {
  const NotificaitonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = AppLayout.appLayoutScaffoldKey.currentContext!.read<NotificationsCubit>();

    return BlocProvider.value(
      value: cubit..getNotifications(),
      child: Scaffold(
        appBar: const NotificationAppBar(),
        body: Padding(
          padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
          child: Column(
            children: [
              Expanded(child: NotificationList()),
              PrimaryTextButton(
                color: AppColors.accent1Shade1,
                minWidth: double.maxFinite,
                label: context.translation!.mark_all_as_read,
                onTap: () => cubit.markAllNotificationRead(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
