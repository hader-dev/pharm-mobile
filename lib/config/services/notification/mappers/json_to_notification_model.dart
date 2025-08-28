import 'package:hader_pharm_mobile/models/notification.dart';

NotificationModel jsonToNotificationModel(Map<String, dynamic> json) {
  return NotificationModel(
    id: json['id'] as String,
    title: json['title'] ?? "Unkown",
    body: json['body'] ?? "Unkown",
    isRead: json['read'] ?? false,
    type: json['type'] ?? "order.created",
    createdAt: DateTime.parse(json['createdAt'] as String),
    clientId: json['clientId'],
    redirectUrl: json['redirectUrl'],
    actionPayload: json['payload'],
  );
}
