part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginSuccessful extends LoginState {}

final class LoginFailed extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoadingUsersDone extends LoginState {}

final class LoadingUsers extends LoginState {}

final class LoadingUsersFailed extends LoginState {}

final class PasswordVisibilityChanged extends LoginState {}

final class LoggedOut extends LoginState {}

final class ResetLinkSent extends LoginState {}

final class EmailOtpResentSuccessfully extends LoginState {
  final String email;

  EmailOtpResentSuccessfully({required this.email});
}
