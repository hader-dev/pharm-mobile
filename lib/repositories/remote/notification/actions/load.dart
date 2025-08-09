import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/notification.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/mappers/json_to_notification.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/params/params_load_notifications.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_load_notifications.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<ResponseLoadNotifications> loadNotifications(
    ParamsLoadNotifications params, INetworkService client) async {
  var decodedResponse = await client.sendRequest(() => client.get(
        Urls.notifications,
      ));

  var parsedList = jsonToNotificationList(decodedResponse);

  return ResponseLoadNotifications(data: parsedList);
}

Future<ResponseLoadNotifications> mockResponse(
    ParamsLoadNotifications params, INetworkService client) async {
  return ResponseLoadNotifications(
    unreadCount: 2,
    data: [
    NotificationModel(
      id: 1,
      title: 'Welcome!',
      body: 'Thanks for joining our app 🎉',
      isRead: false,
      type: 'info',
      createdAt: DateTime.now().subtract(Duration(minutes: 5)),
      clientId: 1,
      redirectUrl: '/welcome',
    ),
    NotificationModel(
      id: 2,
      title: 'New Feature',
      body: 'Check out our brand new dark mode!',
      isRead: false,
      type: 'update',
      clientId: 2,
      createdAt: DateTime.now().subtract(Duration(hours: 2)),
      redirectUrl: '/features/dark-mode',
    ),
    NotificationModel(
      id: 3,
      title: 'Reminder',
      body: 'Your subscription is about to expire.',
      isRead: true,
      type: 'alert',
      createdAt: DateTime.now().subtract(Duration(days: 1)),
      clientId: 3,
      redirectUrl: '/billing',
    ),
    NotificationModel(
      id: 4,
      title: 'Special Offer',
      body: 'Get 50% off your next purchase for 24 hours only!',
      isRead: true,
      clientId: 4,
      type: 'promo',
      createdAt: DateTime.now().subtract(Duration(days: 3)),
      redirectUrl: '/offers',
    ),
  ]);
}
