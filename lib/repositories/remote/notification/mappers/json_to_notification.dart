



import 'package:hader_pharm_mobile/models/notification.dart';

NotificationModel jsonToNotification(Map<String, dynamic> json) => NotificationModel.fromJson(json);


List<NotificationModel> jsonToNotificationList(List<dynamic> json) => json.map((notification) => jsonToNotification(notification)).toList();