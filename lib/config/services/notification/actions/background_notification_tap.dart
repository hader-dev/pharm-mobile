import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/notification/mappers/json_to_notification_model.dart';
import 'package:hader_pharm_mobile/models/notification.dart';

@pragma('vm:entry-point')
void onNotificationResponseTap(NotificationResponse response) {
  final payload = response.payload;
  if (payload != null) {
    final data = jsonDecode(payload);
    final notification = jsonToNotificationModel(data);

    onNotificationTap(notification);
  }
}

void onNotificationTap(NotificationModel notification) {
  final parsedType = NotificationTypeExtension.fromString(notification.type);
  switch (parsedType) {
    case NotificationType.order:
      RoutingManager.router.pushNamed(RoutingManager.ordersDetailsScreen,
          extra: notification.actionPayload["orderId"] ?? "unkown");
      break;

    default:
      break;
  }
}
