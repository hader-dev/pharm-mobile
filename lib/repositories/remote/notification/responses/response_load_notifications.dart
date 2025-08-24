import 'package:hader_pharm_mobile/models/notification.dart';

class ResponseLoadNotifications {
  final List<NotificationModel> data;
  final int totalItems;

  ResponseLoadNotifications({this.data = const [], this.totalItems = 0});
}
