import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hader_pharm_mobile/config/services/firebase/firebase_service_port.dart';

class FirebaseService implements FirebaseServicePort {
  @override
  Future<void> init() async {
    await Firebase.initializeApp();
  }

  @override
  FirebaseMessaging messagingService() {
    return FirebaseMessaging.instance;
  }
}
