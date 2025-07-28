import 'package:hader_pharm_mobile/models/notification.dart';

Map<String, dynamic> mapNotificationModelToJson(NotificationModel model) {
  return {
    'id': model.id,
    'title': model.title,
    'body': model.body,
    'isRead': model.isRead,
    'type': model.type,
    'createdAt': model.createdAt.toIso8601String(),
    'clientId': model.clientId,
    'redirectUrl': model.redirectUrl,
  };
}
