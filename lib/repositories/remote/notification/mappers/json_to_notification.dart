import 'package:hader_pharm_mobile/config/services/notification/mappers/json_to_notification_model.dart';
import 'package:hader_pharm_mobile/models/notification.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_load_notifications.dart';

NotificationModel jsonToNotification(Map<String, dynamic> json) =>
    jsonToNotificationModel(json);

List<NotificationModel> jsonToNotificationList(List<dynamic> json) =>
    json.map((notification) => jsonToNotification(notification)).toList();

ResponseLoadNotifications jsonToNotificationsResponse(
    Map<String, dynamic> json) {
  return ResponseLoadNotifications(
      data: jsonToNotificationList(json['data'] as List<dynamic>),
      totalItems: json['totalItems'] as int);
}
