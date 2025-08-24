import 'package:hader_pharm_mobile/repositories/remote/notification/params/params_load_notifications.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/params/params_mark_read.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_load_notification_one.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_load_notifications.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_mark_all_read.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_mark_read.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_unread_count.dart';

abstract class INotificationRepository {
  Future<ResponseLoadNotifications> getNotifications(
    ParamsLoadNotifications params,
  );

  Future<ResponseLoadNotificationOne> getNotificationById(
      ParamsLoadNotification params);

  Future<void> registerUserDevice(String deviceToken);

  Future<ResponseUnreadCount> getUnreadNotificationsCount();
  Future<ResponseMarkRead> markReadNotification(ParamsMarkRead params);
  Future<ResponseMarkAllRead> markAllReadNotification();
}
