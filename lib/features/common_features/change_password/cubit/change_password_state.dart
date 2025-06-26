part of 'change_password_cubit.dart';

sealed class ChangePasswordState {}

final class ChangePasswordInitial extends ChangePasswordState {}

final class PasswordVisibilityChanged extends ChangePasswordState {}

final class ChangePasswordLoading extends ChangePasswordState {}

final class ChangePasswordSuccessful extends ChangePasswordState {}

final class ChangePasswordFailed extends ChangePasswordState {}
