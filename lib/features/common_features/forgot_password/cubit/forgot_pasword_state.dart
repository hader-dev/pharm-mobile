part of 'forgot_password_cubit.dart';

@immutable
sealed class ForgotPaswordState {
  final GlobalKey<FormState> formKey;
  final GlobalKey<FormFieldState> passwordFieldKey;
  final GlobalKey<FormState> forgotFormKey;
  final GlobalKey<FormFieldState> emailFieldKey;
  final bool isObscured;
  final bool isResendActive;
  final TextEditingController emailController;
  final TextEditingController newPasswordController;
  final String otpCode;

  const ForgotPaswordState(
      {required this.formKey,
      required this.passwordFieldKey,
      required this.isObscured,
      required this.isResendActive,
      required this.forgotFormKey,
      required this.emailFieldKey,
      required this.emailController,
      required this.otpCode,
      required this.newPasswordController});

  ResetLinkSent toResetLinkSent({String? otpCode}) =>
      ResetLinkSent.fromState(state: this, otpCode: otpCode);

  ForgotPasswordEmailStart toForgotPasswordEmailStart() =>
      ForgotPasswordEmailStart.fromState(state: this);
  ResetPasswordSuccess toResetPasswordSuccess() =>
      ResetPasswordSuccess.fromState(state: this);
  ResendOtpLoading toResendOtpLoading() =>
      ResendOtpLoading.fromState(state: this);
  PasswordVisibilityChanged toPasswordVisibilityChanged({
    required bool isObscured,
  }) =>
      PasswordVisibilityChanged.fromState(state: this, isObscured: isObscured);
  TimerCountChanged toCounterTicked(
          {required int count, required bool isResendActive}) =>
      TimerCountChanged.fromState(
          state: this, count: count, isResendActive: isResendActive);

  ForgotPasswordInitial toInitial() => ForgotPasswordInitial.fromState(
        state: this,
      );

  ResetpasswordIsLoading toResetPasswordLoading() =>
      ResetpasswordIsLoading.fromState(
        state: this,
      );

  ResetPasswordFailed toError() => ResetPasswordFailed.fromState(state: this);
}

final class ForgotPasswordInitial extends ForgotPaswordState {
  ForgotPasswordInitial(
      {GlobalKey<FormState>? formKey,
      GlobalKey<FormFieldState>? passwordFieldKey,
      bool? isObscured,
      bool? isResendActive,
      TextEditingController? emailController,
      TextEditingController? newPasswordController,
      GlobalKey<FormState>? forgotFormKey,
      GlobalKey<FormFieldState>? emailFieldKey,
      String? otpCode})
      : super(
          formKey: formKey ?? GlobalKey<FormState>(),
          otpCode: otpCode ?? '',
          forgotFormKey: forgotFormKey ?? GlobalKey<FormState>(),
          emailFieldKey: emailFieldKey ?? GlobalKey<FormFieldState>(),
          passwordFieldKey: passwordFieldKey ?? GlobalKey<FormFieldState>(),
          isObscured: isObscured ?? true,
          isResendActive: isResendActive ?? true,
          emailController: emailController ?? TextEditingController(),
          newPasswordController:
              newPasswordController ?? TextEditingController(),
        );

  ForgotPasswordInitial.fromState({required ForgotPaswordState state})
      : super(
          formKey: state.formKey,
          passwordFieldKey: state.passwordFieldKey,
          otpCode: state.otpCode,
          isObscured: state.isObscured,
          isResendActive: state.isResendActive,
          emailController: state.emailController,
          forgotFormKey: state.forgotFormKey,
          emailFieldKey: state.emailFieldKey,
          newPasswordController: state.newPasswordController,
        );
}

final class ResetLinkSent extends ForgotPaswordState {
  ResetLinkSent.fromState({required ForgotPaswordState state, String? otpCode})
      : super(
          formKey: state.formKey,
          passwordFieldKey: state.passwordFieldKey,
          isObscured: state.isObscured,
          isResendActive: state.isResendActive,
          emailController: state.emailController,
          forgotFormKey: state.forgotFormKey,
          emailFieldKey: state.emailFieldKey,
          newPasswordController: state.newPasswordController,
          otpCode: otpCode ?? state.otpCode,
        );
}

final class ForgotPasswordEmailStart extends ForgotPaswordState {
  ForgotPasswordEmailStart.fromState({
    required ForgotPaswordState state,
  }) : super(
          formKey: state.formKey,
          passwordFieldKey: state.passwordFieldKey,
          isObscured: state.isObscured,
          isResendActive: state.isResendActive,
          emailController: state.emailController,
          newPasswordController: state.newPasswordController,
          otpCode: state.otpCode,
          forgotFormKey: state.forgotFormKey,
          emailFieldKey: state.emailFieldKey,
        );
}

final class ResendOtpLoading extends ForgotPaswordState {
  ResendOtpLoading.fromState({
    required ForgotPaswordState state,
  }) : super(
          formKey: state.formKey,
          passwordFieldKey: state.passwordFieldKey,
          isObscured: state.isObscured,
          isResendActive: state.isResendActive,
          emailController: state.emailController,
          newPasswordController: state.newPasswordController,
          otpCode: state.otpCode,
          forgotFormKey: state.forgotFormKey,
          emailFieldKey: state.emailFieldKey,
        );
}

final class ResetPasswordFailed extends ForgotPaswordState {
  ResetPasswordFailed.fromState({
    required ForgotPaswordState state,
  }) : super(
          formKey: state.formKey,
          passwordFieldKey: state.passwordFieldKey,
          isObscured: state.isObscured,
          isResendActive: state.isResendActive,
          emailController: state.emailController,
          newPasswordController: state.newPasswordController,
          otpCode: state.otpCode,
          forgotFormKey: state.forgotFormKey,
          emailFieldKey: state.emailFieldKey,
        );
}

final class ResetpasswordIsLoading extends ForgotPasswordInitial {
  ResetpasswordIsLoading.fromState({
    required ForgotPaswordState state,
  }) : super(
          formKey: state.formKey,
          passwordFieldKey: state.passwordFieldKey,
          isObscured: state.isObscured,
          isResendActive: state.isResendActive,
          emailController: state.emailController,
          newPasswordController: state.newPasswordController,
          otpCode: state.otpCode,
          forgotFormKey: state.forgotFormKey,
          emailFieldKey: state.emailFieldKey,
        );
}

final class ResetPasswordSuccess extends ForgotPasswordInitial {
  ResetPasswordSuccess.fromState({
    required ForgotPaswordState state,
  }) : super(
          formKey: state.formKey,
          passwordFieldKey: state.passwordFieldKey,
          isObscured: state.isObscured,
          isResendActive: state.isResendActive,
          emailController: state.emailController,
          newPasswordController: state.newPasswordController,
          otpCode: state.otpCode,
          forgotFormKey: state.forgotFormKey,
          emailFieldKey: state.emailFieldKey,
        );
}

final class PasswordVisibilityChanged extends ForgotPasswordInitial {
  PasswordVisibilityChanged.fromState({
    required ForgotPaswordState state,
    required bool isObscured,
  }) : super(
          formKey: state.formKey,
          passwordFieldKey: state.passwordFieldKey,
          isObscured: isObscured,
          isResendActive: state.isResendActive,
          emailController: state.emailController,
          newPasswordController: state.newPasswordController,
          otpCode: state.otpCode,
          forgotFormKey: state.forgotFormKey,
          emailFieldKey: state.emailFieldKey,
        );
}

final class TimerCountChanged extends ForgotPasswordInitial {
  final int count;
  TimerCountChanged({required this.count});

  TimerCountChanged.fromState({
    required ForgotPaswordState state,
    required this.count,
    required bool isResendActive,
  }) : super(
          formKey: state.formKey,
          passwordFieldKey: state.passwordFieldKey,
          isObscured: state.isObscured,
          isResendActive: isResendActive,
          emailController: state.emailController,
          newPasswordController: state.newPasswordController,
          otpCode: state.otpCode,
          forgotFormKey: state.forgotFormKey,
          emailFieldKey: state.emailFieldKey,
        );
}
