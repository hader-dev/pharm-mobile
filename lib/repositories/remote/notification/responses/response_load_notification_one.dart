import 'package:hader_pharm_mobile/models/notification.dart';

class ResponseLoadNotificationOne {
  final NotificationModel? data;
  final int totalItems;
  final int unreadCount;

  ResponseLoadNotificationOne(
      {this.data, this.totalItems = 0, this.unreadCount = 0});
}
