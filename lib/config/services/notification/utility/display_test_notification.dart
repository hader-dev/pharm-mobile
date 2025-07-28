import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../actions/handle_remote_message.dart';
import '../notification_channels.dart';
import 'mock_remote_message.dart';

Future<void> showTestNotificationManually() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    NotificationChannel.id,
    NotificationChannel.name,
    channelDescription: NotificationChannel.description,
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0, // notification id
    'Test Notification', // title
    'This is the notification body.', // body
    platformChannelSpecifics,
    payload: 'test_payload', // optional
  );
}

Future<void> showTestNotificationAsIfRemoteMessage() async {
  final mockMessage = mockRemoteMessage();
  await handleRemoteMessage(mockMessage);
}
