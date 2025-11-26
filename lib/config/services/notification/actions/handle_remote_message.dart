import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart' show RoutingManager;

import '../notification_channels.dart';
import '../notification_plugin.dart';

Future<void> handleRemoteMessageShowNotification(RemoteMessage message) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    NotificationChannel.id,
    NotificationChannel.name,
    channelDescription: NotificationChannel.description,
    importance: Importance.max,
    priority: Priority.max,
  );

  const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

  final String? title = message.notification?.title ?? message.data['title'];
  final String? body = message.notification?.body ?? message.data['body'];

  await flutterLocalNotificationsPlugin.show(
    message.hashCode,
    title,
    body,
    platformDetails,
    payload: jsonEncode(message.data),
  );
}

Future<void> forGroundRemoteMessage(RemoteMessage message) async {
  await handleRemoteMessageShowNotification(message);
  getItInstance.get<StreamController>().sink.add(message.data);
}

Future<void> backGroundRemoteMessage(RemoteMessage message) async {
  await handleRemoteMessageShowNotification(message);

  RoutingManager.router.pushNamed(RoutingManager.allAnnouncementsScreen);
}

Future<void> terminatedAppRemoteMessage(RemoteMessage message) async {
  await handleRemoteMessageShowNotification(message);

  RoutingManager.router.pushNamed(RoutingManager.splashScreen, pathParameters: {});
}
