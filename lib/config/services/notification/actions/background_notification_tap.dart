import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/notification/mappers/json_to_notification_model.dart';
import 'package:hader_pharm_mobile/models/notification.dart';

@pragma('vm:entry-point')
void onNotificationResponseTap(NotificationResponse response) {
  final payload = response.payload;

  debugPrint("Payload: $payload");
  if (payload != null) {
    final data = jsonDecode(payload);

    try {
      final notification =
          jsonToNotificationModel(jsonDecode(data["notification"]));

      onNotificationTap(notification);
    } catch (e, stack) {
      debugPrint("$e");
      debugPrintStack(stackTrace: stack);
    }
  }
}

void onNotificationTap(NotificationModel notification) {
  final parsedType = NotificationTypeExtension.fromString(notification.type);
  debugPrint("NotificationType: ${notification.actionPayload}");

  switch (parsedType) {
    case NotificationType.order:
      RoutingManager.router.pushNamed(RoutingManager.ordersDetailsScreen,
          extra: notification.actionPayload["orderId"] ?? "unkown");
      break;

    case NotificationType.announcement:
      RoutingManager.router.pushNamed(RoutingManager.announcementDetailsScreen,
          extra: notification.actionPayload["announcementId"] ?? "unkown");
      break;

    default:
      break;
  }
}
