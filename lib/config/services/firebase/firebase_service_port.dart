import 'package:firebase_messaging/firebase_messaging.dart';

abstract class FirebaseServicePort {
  Future<void> init();

  FirebaseMessaging messagingService();
}
