import '../../../models/notification.dart';

abstract class INotificationRepository {
  Future<List<NotificationModel>> getNotifications();
  Future<NotificationModel> getNotificationById(int id);
}
