import 'dart:convert' show jsonDecode;

import 'package:firebase_messaging/firebase_messaging.dart' show FirebaseMessaging, RemoteMessage;
import 'package:hader_pharm_mobile/config/services/notification/mappers/json_to_notification_model.dart'
    show jsonToNotificationModel;

import 'background_notification_tap.dart' show onNotificationTapped;

/*
this function when the notification is tapped & the app is already killed 
this function should be high order function
 */
Future<void> handleTerminatedAppNotificationTab() async {
  RemoteMessage? notification = await FirebaseMessaging.instance.getInitialMessage();
  if (notification != null) {
    Map<String, dynamic> decodedNotificationPayload = jsonDecode(notification.data["notification"]);
    onNotificationTapped(jsonToNotificationModel(decodedNotificationPayload));
  }
}
