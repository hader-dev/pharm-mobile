import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/params/params_load_notifications.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_load_notifications.dart';

abstract class INotificationService {
  Future<void> init();

  Future<void> registerUserDevice();

  Future<void> handleRemoteMessage(RemoteMessage message);

  Future<ResponseLoadNotifications> getNotifications(ParamsLoadNotifications paramsLoadNotifications);
}
