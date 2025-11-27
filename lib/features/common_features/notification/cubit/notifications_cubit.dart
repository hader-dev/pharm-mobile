import 'dart:async' show Timer, StreamController;
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart' show RemoteMessage;
import 'package:flutter/widgets.dart';
import 'package:hader_pharm_mobile/config/services/notification/notification_service_port.dart';
import 'package:hader_pharm_mobile/models/notification.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/params/params_load_notifications.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/params/params_mark_read.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../../../config/services/notification/mappers/json_to_notification_model.dart' show jsonToNotificationModel;

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationState> {
  int totalItemsCount = 0;
  int offSet = 0;
  Timer? _debounce;
  List<NotificationModel> notifications = List.empty(growable: true);
  int unreadCount = 0;

  final INotificationService notificationService;
  final ScrollController scrollController;
  final StreamController fcmNotificationsStream;

  final AudioPlayer player = AudioPlayer();
  NotificationsCubit(
      {required this.notificationService, required this.scrollController, required this.fcmNotificationsStream})
      : super(NotificationsInitial()) {
    _onScroll();
    if (!fcmNotificationsStream.hasListener) {
      debugPrint("Listening to fcmNotificationsStream");
      fcmNotificationsStream.stream.listen((event) {
        addReceivedFcmNotification(event);
      });
    }
  }

  void addReceivedFcmNotification(RemoteMessage notificationObject) async {
    var decodedNotificationPayload = jsonDecode(notificationObject.data["notification"]);
    NotificationModel notificationModel = jsonToNotificationModel({
      "title": notificationObject.notification?.title,
      "body": notificationObject.notification?.body,
      ...decodedNotificationPayload
    });
    unreadCount = unreadCount + 1;
    player.play(AssetSource(SoundAssetStrings.notificationSound));

    notifications.insert(0, notificationModel);
    emit(NotificationsLoaded());
  }

  Future<void> getUnreadNotificationsCount() async {
    try {
      emit(NotificationsLoading());
      var response = await notificationService.getUnreadNotificationsCount();

      unreadCount = response.unreadCount;
      emit(NotificationsLoaded());
    } catch (e, stack) {
      debugPrint("Error fetching unread notifications count: $e");
      debugPrintStack(stackTrace: stack);
      emit(NotificationsLoadingFailed());
    }
  }

  Future<void> getNotifications({
    int offset = 0,
  }) async {
    try {
      emit(NotificationsLoading());
      var response = await notificationService.getNotifications(ParamsLoadNotifications(
        offset: offSet,
      ));

      totalItemsCount = response.totalItems;
      notifications = response.data;

      emit(NotificationsLoaded());
    } catch (e, stack) {
      debugPrint("Error fetching notifications: $e");
      debugPrintStack(stackTrace: stack);
      emit(NotificationsLoadingFailed());
    }
  }

  Future<void> loadMoreNotifications() async {
    try {
      if (offSet >= totalItemsCount) {
        emit(NotificationsLoadLimitReached());
        return;
      }

      offSet = offSet + PaginationConstants.resultsPerPage;
      emit(NotificationsLoading());
      var response = await notificationService.getNotifications(ParamsLoadNotifications(
        offset: offSet,
      ));
      totalItemsCount = response.totalItems;
      notifications.addAll(response.data);
      emit(NotificationsLoaded());
    } catch (e) {
      offSet = offSet - PaginationConstants.resultsPerPage;
      emit(NotificationsLoadingFailed());
    }
  }

  void searchMedicineCatalog(String? text) => _debounceFunction(() => getNotifications());

  Future<void> _debounceFunction(Future<void> Function() func, [int milliseconds = 500]) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: milliseconds), () async {
      await func();
      _debounce = null;
    });
  }

  void _onScroll() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
        if (offSet < totalItemsCount) {
          await loadMoreNotifications();
        } else {
          emit(NotificationsLoadLimitReached());
        }
      }
    });
  }

  void markReadNotification(NotificationModel notification) {
    final updatedNotifications = notifications.map((item) {
      if (item.id == notification.id && !item.isRead) {
        unreadCount = unreadCount - 1;
        return item.copyWith(isRead: true);
      }
      return item;
    }).toList();
    notifications = updatedNotifications;
    notificationService.markReadNotification(ParamsMarkRead(id: notification.id));
    emit(NotificationsLoaded());
  }

  void markAllNotificationRead() {
    notifications = notifications.map((item) => item.copyWith(isRead: true)).toList(growable: false);
    unreadCount = 0;
    notificationService.markReadAllNotifications();
    emit(NotificationsLoaded());
  }

  @override
  Future<void> close() async {
    scrollController.dispose();
    await Future.wait([fcmNotificationsStream.close(), player.dispose()]);

    return super.close();
  }
}
