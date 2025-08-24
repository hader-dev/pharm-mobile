import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/actions/mark_all_read.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/actions/mark_read.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/actions/unread_count.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/params/params_load_notifications.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/params/params_mark_read.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_load_notification_one.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_load_notifications.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_mark_all_read.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_mark_read.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_unread_count.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

import 'actions/load.dart' as load_actions;
import 'actions/load_one.dart' as load_actions;
import 'notification_repository.dart';

class NotificationRepository extends INotificationRepository {
  final INetworkService client;

  NotificationRepository({required this.client});

  @override
  Future<ResponseLoadNotificationOne> getNotificationById(
      ParamsLoadNotification params) async {
    return load_actions.loadOneNotification(params, client);
  }

  @override
  Future<ResponseLoadNotifications> getNotifications(
      ParamsLoadNotifications params) async {
    return load_actions.loadNotifications(params, client);
  }

  @override
  Future<void> registerUserDevice(String deviceToken) async {
    return await client.sendRequest(() => client.post(Urls.registerUserDevice,
        payload: {"token": deviceToken, "platform": "android"}));
  }

  @override
  Future<ResponseUnreadCount> getUnreadNotificationsCount() async {
    return loadNotificationsUnreadCount(client);
  }

  @override
  Future<ResponseMarkAllRead> markAllReadNotification() async {
    return markAllRead(client);
  }

  @override
  Future<ResponseMarkRead> markReadNotification(ParamsMarkRead params) {
    return markRead(params, client);
  }
}
