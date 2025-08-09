
import 'package:hader_pharm_mobile/models/notification.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/params/params_load_notifications.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_load_notifications.dart';

abstract class INotificationRepository {
  Future<ResponseLoadNotifications> getNotifications(ParamsLoadNotifications params,);

  Future<NotificationModel> getNotificationById(int id);

  Future<void> registerUserDevice(String deviceToken);
}
