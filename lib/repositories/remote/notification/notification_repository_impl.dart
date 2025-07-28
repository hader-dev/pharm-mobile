import 'dart:convert';

import '../../../models/notification.dart';
import '../../../utils/assets_strings.dart';
import '../../../utils/data_loader_helper.dart';
import 'notification_repository.dart';

class NotificationRepository extends INotificationRepository {
  @override
  Future<NotificationModel> getNotificationById(int id) async {
    var data = jsonDecode(await DataLoaderHelper.loadDummyData(
        JsonAssetStrings.notificationsJson));
    return NotificationModel.fromJson(data[0]);
  }

  @override
  Future<List<NotificationModel>> getNotifications() async {
    var data = jsonDecode(await DataLoaderHelper.loadDummyData(
        JsonAssetStrings.notificationsJson));
    return (data as List)
        .map((prod) => NotificationModel.fromJson(prod))
        .toList();
  }

  @override
  Future<void> registerUserDevice(String deviceToken) {
    // TODO: implement registerUserDevice
    throw UnimplementedError();
  }
}
