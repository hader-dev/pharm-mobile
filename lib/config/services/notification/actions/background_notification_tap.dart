import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hader_pharm_mobile/models/notification.dart';

@pragma('vm:entry-point')
void onNotificationTap(NotificationResponse response) {
  final payload = response.payload;
  if (payload != null) {
    final data = jsonDecode(payload);
    final notification = NotificationModel.fromJson(data);
    debugPrint("Tapped local notification: ${notification.title}");
  }
}
