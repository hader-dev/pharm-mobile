part of 'check_email_cubit.dart';

sealed class CheckEmailState {}

final class CheckEmailInitial extends CheckEmailState {}

final class CheckEmailLoading extends CheckEmailState {}

final class CheckEmailSuccuss extends CheckEmailState {}

final class CheckEmailFailed extends CheckEmailState {}

final class InitEmail extends CheckEmailState {}

final class TimerCountChanged extends CheckEmailState {
  final int count;
  TimerCountChanged({required this.count});
}
