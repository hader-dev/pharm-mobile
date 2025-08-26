import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/notification/actions/handle_notifciation.dart';
import 'package:hader_pharm_mobile/features/common_features/notification/cubit/notifications_cubit.dart';
import 'package:hader_pharm_mobile/models/notification.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_date_helper.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget(
      {super.key, required this.notification, required this.cubit});

  final NotificationModel notification;
  final NotificationsCubit cubit;

  @override
  Widget build(BuildContext context) {
    final onSurfaceColor = !notification.isRead ? Colors.white : Colors.black;
    final surfaceColor =
        !notification.isRead ? AppColors.accent1Shade2 : Colors.white;
    final onSurfaceHintColor = !notification.isRead
        ? AppColors.accent1Shade2Deemphasized
        : Colors.grey[500];

    return InkWell(
      onTap: () => handleNotifciation(notification, cubit),
      child: Card(
        color: surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSizesManager.p8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.title,
                style: context.responsiveTextTheme.current.body1Medium
                    .copyWith(color: onSurfaceColor),
              ),
              Text(
                notification.body,
                style: context.responsiveTextTheme.current.body3Medium
                    .copyWith(color: onSurfaceColor),
              ),
              Text(
                notification.createdAt.getTimingAgo(context.translation!),
                style: context.responsiveTextTheme.current.body3Medium
                    .copyWith(color: onSurfaceHintColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
