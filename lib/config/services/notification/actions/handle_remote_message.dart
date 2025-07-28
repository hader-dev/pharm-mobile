import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../notification_channels.dart';
import '../notification_plugin.dart';

Future<void> handleRemoteMessage(RemoteMessage message) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    NotificationChannel.id,
    NotificationChannel.name,
    channelDescription: NotificationChannel.description,
    importance: Importance.high,
    priority: Priority.high,
  );

  const NotificationDetails platformDetails =
      NotificationDetails(android: androidDetails);

  final String? title = message.notification?.title ?? message.data['title'];
  final String? body = message.notification?.body ?? message.data['body'];

  await flutterLocalNotificationsPlugin.show(
    message.hashCode, // unique notification id
    title,
    body,
    platformDetails,
    payload: jsonEncode(message.data),
  );
}
