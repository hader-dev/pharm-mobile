part of 'change_password_cubit.dart';

sealed class ChangePasswordState {
  final bool isObscured;

  final bool isLogin;
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;

  ChangePasswordState(
      {required this.isObscured,
      required this.isLogin,
      required this.currentPasswordController,
      required this.newPasswordController,
      required this.confirmPasswordController});

  PasswordVisibilityChanged toPasswordVisibilityChanged() =>
      PasswordVisibilityChanged.fromState(state: this, isObscured: !isObscured);

  ChangePasswordSuccessful toPasswordUpdateSuccess() =>
      ChangePasswordSuccessful.fromState(state: this);

  ChangePasswordFailed toPasswordUpdatedFailed() =>
      ChangePasswordFailed.fromState(state: this);

  ChangePasswordLoading toChangePasswordLoading() =>
      ChangePasswordLoading.fromState(state: this);
}

final class ChangePasswordInitial extends ChangePasswordState {
  ChangePasswordInitial({
    super.isObscured = true,
    super.isLogin = false,
    TextEditingController? currentPasswordController,
    TextEditingController? newPasswordController,
    TextEditingController? confirmPasswordController,
  }) : super(
            currentPasswordController:
                currentPasswordController ?? TextEditingController(),
            newPasswordController:
                newPasswordController ?? TextEditingController(),
            confirmPasswordController:
                confirmPasswordController ?? TextEditingController());
}

final class PasswordVisibilityChanged extends ChangePasswordInitial {
  PasswordVisibilityChanged.fromState(
      {required ChangePasswordState state, required super.isObscured})
      : super(
            isLogin: state.isLogin,
            currentPasswordController: state.currentPasswordController,
            newPasswordController: state.newPasswordController,
            confirmPasswordController: state.confirmPasswordController);
}

final class ChangePasswordLoading extends ChangePasswordInitial {
  ChangePasswordLoading.fromState({required ChangePasswordState state})
      : super(
            isLogin: state.isLogin,
            currentPasswordController: state.currentPasswordController,
            newPasswordController: state.newPasswordController,
            confirmPasswordController: state.confirmPasswordController);
}

final class ChangePasswordSuccessful extends ChangePasswordInitial {
  ChangePasswordSuccessful.fromState({required ChangePasswordState state})
      : super(
            isLogin: state.isLogin,
            currentPasswordController: state.currentPasswordController,
            newPasswordController: state.newPasswordController,
            confirmPasswordController: state.confirmPasswordController);
}

final class ChangePasswordFailed extends ChangePasswordInitial {
  ChangePasswordFailed.fromState({required ChangePasswordState state})
      : super(
            isLogin: state.isLogin,
            currentPasswordController: state.currentPasswordController,
            newPasswordController: state.newPasswordController,
            confirmPasswordController: state.confirmPasswordController);
}
