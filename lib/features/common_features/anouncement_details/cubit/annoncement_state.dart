part of 'announcement_cubit.dart';

sealed class AnnouncementState {}

final class AnnouncementStateInitial extends AnnouncementState {}

final class AnnouncementIsLoading extends AnnouncementState {}

final class AnnouncementLoaded extends AnnouncementState {}

final class AnnouncementLoadingError extends AnnouncementState {}

final class AnnouncementPageChanged extends AnnouncementState {}

final class AnnouncementUpdated extends AnnouncementState {}


final class MedicineLiked extends AnnouncementState {
  String medicineId;

  MedicineLiked({required this.medicineId});
}

final class MedicineLikeFailed extends AnnouncementState {
  String medicineId;

  MedicineLikeFailed({required this.medicineId});
}

final class ParapharmaLiked extends AnnouncementState {
  String paraPharmaId;

  ParapharmaLiked({required this.paraPharmaId});
}

final class ParaPharmaLikeFailed extends AnnouncementState {
  String paraPharmaId;

  ParaPharmaLikeFailed({required this.paraPharmaId});
}
