part of 'all_announcements_cubit.dart';

abstract class AllAnnouncementsState extends Equatable {
  final List<AnnouncementModel> announcements;
  final bool hasReachedMax;

  const AllAnnouncementsState({
    required this.announcements,
    required this.hasReachedMax,
  });

  @override
  List<Object> get props => [announcements, hasReachedMax];
}

class AllAnnouncementsInitial extends AllAnnouncementsState {
  const AllAnnouncementsInitial()
      : super(announcements: const [], hasReachedMax: false);
}

class AllAnnouncementsLoading extends AllAnnouncementsState {
  const AllAnnouncementsLoading({
    required super.announcements,
    required super.hasReachedMax,
  });
}

class AllAnnouncementsLoaded extends AllAnnouncementsState {
  const AllAnnouncementsLoaded({
    required super.announcements,
    required super.hasReachedMax,
  });
}

class AnnouncementsLoadLimitReached extends AllAnnouncementsState {
  const AnnouncementsLoadLimitReached({
    required super.announcements,
    required super.hasReachedMax,
  });
}

class AllAnnouncementsError extends AllAnnouncementsState {
  final String message;

  const AllAnnouncementsError({
    required super.announcements,
    required super.hasReachedMax,
    required this.message,
  });

  @override
  List<Object> get props => [announcements, hasReachedMax, message];
}
