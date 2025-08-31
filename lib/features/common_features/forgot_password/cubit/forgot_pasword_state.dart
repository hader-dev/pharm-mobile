part of 'forgot_password_cubit.dart';

@immutable
sealed class ForgotPaswordState {}

final class ResetLinkSent extends ForgotPaswordState {}

final class ForgotPasswordInitial extends ForgotPaswordState {}

final class ForgotPasswordEmailStart extends ForgotPaswordState {}

final class ResendOtpLoading extends ForgotPaswordState {}

final class ResetPasswordFailed extends ForgotPaswordState {}

final class ResetpasswordIsLoading extends ForgotPaswordState {}

final class ResetPasswordSuccess extends ForgotPaswordState {}

final class PasswordVisibilityChanged extends ForgotPaswordState {}

final class TimerCountChanged extends ForgotPaswordState {
  final int count;
  TimerCountChanged({required this.count});
}
