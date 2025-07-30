part of 'forgot_password_cubit.dart';

@immutable
sealed class ForgotPaswordState {}

final class ResetLinkSent extends ForgotPaswordState {}
final class ForgotPasswordInitial extends ForgotPaswordState {}
