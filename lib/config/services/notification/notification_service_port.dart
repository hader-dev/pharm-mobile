import 'package:firebase_messaging/firebase_messaging.dart';

abstract class NotificationServicePort {
  Future<void> init();

  Future<void> registerUserDevice();

  Future<void> handleRemoteMessage(RemoteMessage message);
}
