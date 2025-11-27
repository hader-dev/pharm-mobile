import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/params/params_load_notifications.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/params/params_mark_read.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_load_notifications.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_mark_all_read.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_mark_read.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_unread_count.dart';

abstract class INotificationService {
  Future<void> init();

  Future<void> registerUserDevice();

  Future<void> handleForegroundRemoteMessage(RemoteMessage message);

  Future<ResponseLoadNotifications> getNotifications(ParamsLoadNotifications paramsLoadNotifications);

  Future<ResponseUnreadCount> getUnreadNotificationsCount();

  Future<ResponseMarkRead> markReadNotification(ParamsMarkRead params);

  Future<ResponseMarkAllRead> markReadAllNotifications();
}
