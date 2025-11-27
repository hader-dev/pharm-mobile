import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/notification/cubit/notifications_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/notification/widgets/notification_widget.dart';

import '../../../common/shimmers/notification.dart' show NotificationWidgetShimmer;

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NotificationsCubit>();

    return BlocBuilder<NotificationsCubit, NotificationState>(builder: (context, state) {
      if (state is NotificationsLoading) {
        return ListView(children: List.generate(10, (index) => NotificationWidgetShimmer()));
      }

      if (cubit.notifications.isEmpty) {
        return EmptyListWidget(
          onRefresh: cubit.getNotifications,
        );
      }

      return RefreshIndicator(
        onRefresh: cubit.getNotifications,
        child: ListView.builder(
          itemCount: cubit.notifications.length,
          itemBuilder: (ctx, idx) => NotificationWidget(
            notification: cubit.notifications[idx],
            cubit: cubit,
          ),
        ),
      );
    });
  }
}
