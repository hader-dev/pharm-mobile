part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState({required this.announcements});
  final List<AnnouncementModel> announcements;

  PromotionLoading toLoading() => PromotionLoading.fromState(state: this);
  PromotionLoadingFailed toLoadingFailed() =>
      PromotionLoadingFailed.fromState(state: this);
  PromotionLoadingSuccess toLoadingSuccess({
    required List<AnnouncementModel> announcements,
  }) =>
      PromotionLoadingSuccess.fromState(
          state: this, announcements: announcements);

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {
  const HomeInitial({super.announcements = const []});
}

// promotions
final class PromotionLoading extends HomeState {
  PromotionLoading.fromState({required HomeState state})
      : super(announcements: state.announcements);
}

final class PromotionLoadingFailed extends HomeState {
  PromotionLoadingFailed.fromState({required HomeState state})
      : super(announcements: state.announcements);
}

final class PromotionLoadingSuccess extends HomeState {
  const PromotionLoadingSuccess.fromState(
      {required HomeState state, required super.announcements});
}
