part of 'notifications_cubit.dart';

sealed class NotificationState {}

final class NotificationsInitial extends NotificationState {}

// Notifications products states

final class NotificationsLoading extends NotificationState {}

final class LoadingMoreNotifications extends NotificationState {}

final class NotificationsLoaded extends NotificationState {}

final class NotificationsLoadingFailed extends NotificationState {}

//Search Limit Reached State :
final class NotificationsLoadLimitReached extends NotificationState {}
