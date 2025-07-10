part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

// promotions
final class PromotionLoading extends HomeState {}

final class PromotionLoadingFailed extends HomeState {}

final class PromotionLoadingSuccess extends HomeState {}
