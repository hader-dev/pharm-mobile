import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/features/common_features/notification/cubit/notifications_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/notification/widgets/notification_widget.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NotificationsCubit>();

    return BlocBuilder<NotificationsCubit, NotificationState>(
        builder: (context, state) {
      if (state is NotificationsLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (cubit.notifications.isEmpty) {
        return Center(
          child: EmptyListWidget(),
        );
      }

      return ListView.builder(
        itemCount: cubit.notifications.length,
        itemBuilder: (ctx, idx) =>
            NotificationWidget(notification: cubit.notifications[idx], cubit: cubit,),
      );
    });
  }
}
