import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hader_pharm_mobile/config/services/firebase/firebase_service.dart';
import 'package:hader_pharm_mobile/config/services/firebase/firebase_service_port.dart';
import 'package:hader_pharm_mobile/config/services/notification/notification_service_port.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/notification_repository.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/params/params_load_notifications.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/params/params_mark_read.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_load_notifications.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_mark_all_read.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_mark_read.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_unread_count.dart';

import 'actions/background_notification_tap.dart';
import 'actions/handle_remote_message.dart' as actions;
import 'notification_channels.dart';
import 'notification_plugin.dart';

class NotificationService implements INotificationService {
  final FirebaseServicePort firebaseService;
  final INotificationRepository notificationRepository;

  const NotificationService(
      {required this.firebaseService, required this.notificationRepository});

  @override
  Future<void> init() async {
    final FirebaseMessaging messaging = firebaseService.messagingService();

    await messaging.requestPermission();

    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await _initNotifications();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      actions.backGroundRemoteMessage(event);
    });
    FirebaseMessaging.onMessage.listen(
      (event) {
        actions.forGroundRemoteMessage(event);
      },
    );

    String? token = await messaging.getToken();

    debugPrint("DeviceToken $token");
  }

  @override
  Future<void> registerUserDevice() async {
    final FirebaseMessaging messaging = firebaseService.messagingService();
    String? token = await messaging.getToken();

    debugPrint("DeviceToken $token");

    await notificationRepository.registerUserDevice(token!);
  }

  Future<void> _initNotifications() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onNotificationResponseTap,
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      NotificationChannel.id,
      NotificationChannel.name,
      description: NotificationChannel.description,
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  @override
  Future<void> handleForegroundRemoteMessage(RemoteMessage message) async {
    actions.handleRemoteMessageShowNotification(message);
  }

  @override
  Future<ResponseLoadNotifications> getNotifications(
      ParamsLoadNotifications paramsLoadNotifications) async {
    return notificationRepository.getNotifications(paramsLoadNotifications);
  }

  @override
  Future<ResponseUnreadCount> getUnreadNotificationsCount() {
    return notificationRepository.getUnreadNotificationsCount();
  }

  @override
  Future<ResponseMarkRead> markReadNotification(ParamsMarkRead params) {
    return notificationRepository.markReadNotification(params);
  }

  @override
  Future<ResponseMarkAllRead> markReadAllNotifications() async {
    return notificationRepository.markAllReadNotification();
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await FirebaseService().init();
  actions.handleRemoteMessageShowNotification(message);
}
