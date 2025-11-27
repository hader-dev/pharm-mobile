import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart' show getItInstance;
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/dividers.dart';
import 'package:hader_pharm_mobile/features/common_features/notification/actions/handle_notifciation.dart';
import 'package:hader_pharm_mobile/features/common_features/notification/cubit/notifications_cubit.dart';
import 'package:hader_pharm_mobile/models/notification.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart' show DrawableAssetStrings;
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_date_helper.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../config/services/network/network_interface.dart' show INetworkService;

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
        ? context.responsiveTextTheme.current.body2Medium
        : context.responsiveTextTheme.current.body3Medium;
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
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: notification.actionPayload["publisherImagePath"] == null
                                ? AssetImage(
                                    DrawableAssetStrings.newNotificationIcon,
                                  )
                                : CachedNetworkImageProvider(
                                    getItInstance
                                        .get<INetworkService>()
                                        .getFilesPath(notification.actionPayload["publisherImagePath"]),
                                  )),
                        Positioned(
                            right: -4,
                            bottom: -4,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.grey.shade100, width: 2),
                                  ),
                                  height: 35,
                                  width: 35,
                                ),
                                Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    height: 30,
                                    width: 30,
                                    child: Icon(
                                      icon,
                                      size: context.responsiveAppSizeTheme.current.iconSize16,
                                    )),
                              ],
                            ))
                      ],
                    )
                    //  Icon(
                    //   icon,
                    //   color: onSurfaceColor,
                    //   size: context.responsiveAppSizeTheme.current.iconSize30,
                    // ),
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
