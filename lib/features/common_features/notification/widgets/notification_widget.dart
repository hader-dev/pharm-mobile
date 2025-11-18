import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/dividers.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/notification/actions/handle_notifciation.dart';
import 'package:hader_pharm_mobile/features/common_features/notification/cubit/notifications_cubit.dart';
import 'package:hader_pharm_mobile/models/notification.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_date_helper.dart';
import 'package:iconsax/iconsax.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key, required this.notification, required this.cubit});

  final NotificationModel notification;
  final NotificationsCubit cubit;

  @override
  Widget build(BuildContext context) {
    final onSurfaceColor = Colors.black;
    final onSurfaceDescriptionColor = Colors.black54;
    final surfaceColor = !notification.isRead ? AppColors.accent1Shade1.withAlpha(10) : Colors.white;
    final onSurfaceHintColor = !notification.isRead ? Colors.grey : Colors.grey[400];
    final titleTextWeight = !notification.isRead ? FontWeight.w700 : FontWeight.w500;
    final descriptionTextStyle = !notification.isRead
        ? context.responsiveTextTheme.current.body1Medium
        : context.responsiveTextTheme.current.body2Medium;
    final parsedType = NotificationTypeExtension.fromString(notification.type);

    final IconData icon = parsedType == NotificationType.order ? Iconsax.shop : Iconsax.box;

    return InkWell(
      onTap: () => handleNotifciation(notification, cubit),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.commonWidgetsRadius),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.responsiveAppSizeTheme.current.p16),
                  child: Icon(
                    icon,
                    color: onSurfaceColor,
                    size: context.responsiveAppSizeTheme.current.iconSize30,
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(vertical: context.responsiveAppSizeTheme.current.p8),
                  child: Column(
                    spacing: context.responsiveAppSizeTheme.current.p4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        notification.title,
                        style: context.responsiveTextTheme.current.headLine4SemiBold
                            .copyWith(color: onSurfaceColor, fontWeight: titleTextWeight),
                      ),
                      Text(
                        notification.body,
                        style: descriptionTextStyle.copyWith(color: onSurfaceDescriptionColor),
                      ),
                      Text(
                        notification.createdAt.getTimingAgo(context.translation!),
                        style: context.responsiveTextTheme.current.body3Medium.copyWith(color: onSurfaceHintColor),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
          AppDivider(
            indent: context.responsiveAppSizeTheme.current.p4,
            endIndent: context.responsiveAppSizeTheme.current.p4,
            color: const Color.fromARGB(255, 247, 247, 247),
          )
        ],
      ),
    );
  }
}
