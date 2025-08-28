import 'package:hader_pharm_mobile/config/services/notification/mappers/notifciation_model_to_json.dart';
import 'package:hader_pharm_mobile/models/notification.dart';

NotificationModel mockNotificationModel() {
  return NotificationModel(
    id: "0",
    title: 'Mock Notification Title',
    body: 'This is a mock notification body for testing purposes.',
    isRead: false,
    type: 'order.created',
    createdAt: DateTime.now(),
    clientId: "0",
    actionPayload: {"orderId": "test_payload"},
    redirectUrl: '/mock/route',
  );
}

Map<String, dynamic> mockNotificationModelAsJson() {
  final mock = mockNotificationModel();

  return mapNotificationModelToJson(mock);
}
