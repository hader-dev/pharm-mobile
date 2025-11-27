import 'package:hader_pharm_mobile/config/services/notification/actions/background_notification_tap.dart';
import 'package:hader_pharm_mobile/features/common_features/notification/cubit/notifications_cubit.dart';
import 'package:hader_pharm_mobile/models/notification.dart';

void handleNotifciation(NotificationModel notification, NotificationsCubit cubit) {
  cubit.markReadNotification(notification);
  onNotificationTapped(notification);
}
