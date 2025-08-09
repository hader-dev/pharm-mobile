import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/common_features/notification/cubit/notifications_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/notification/view/notification_list.dart';
import 'package:hader_pharm_mobile/features/common_features/notification/widgets/notification_appbar.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

class NotificaitonScreen extends StatelessWidget {
  const NotificaitonScreen({super.key});

  @override  Widget build(BuildContext context) {

    final cubit = AppLayout.appLayoutScaffoldKey.currentContext!.read<NotificationsCubit>();

    return BlocProvider.value(
      value:  cubit,
      child: Scaffold(
        appBar: const NotificationAppbar(),
        body: Padding(
          padding: const EdgeInsets.all(AppSizesManager.p8),
          child: NotificationList(),
        ),
      ),
    );
  }
}
