part of 'login_cubit.dart';

@immutable
sealed class LoginState {
  final bool isObscured;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final GlobalKey<FormState> formKey;
  final GlobalKey<FormFieldState> emailFieldKey;

  const LoginState(
      {required this.isObscured,
      required this.formKey,
      required this.emailFieldKey,
      required this.emailController,
      required this.passwordController});

  LoginSuccessful toLoginSuccessful() => LoginSuccessful.fromState(state: this);
  LoginFailed toLoginFailed() => LoginFailed.fromState(state: this);
  LoginLoading toLoginLoading() => LoginLoading.fromState(state: this);
  LoadingUsersDone toLoadingUsersDone() =>
      LoadingUsersDone.fromState(state: this);
  LoadingUsers toLoadingUsers() => LoadingUsers.fromState(state: this);
  LoadingUsersFailed toLoadingUsersFailed() =>
      LoadingUsersFailed.fromState(state: this);
  PasswordVisibilityChanged toPasswordVisibilityChanged(
          {required bool isObscured}) =>
      PasswordVisibilityChanged.fromState(state: this, isObscured: isObscured);
  LoggedOut toLoggedOut() => LoggedOut.fromState(state: this);

  ForgotPassword toForgotPassword() => ForgotPassword.fromState(state: this);
  EmailOtpResentSuccessfully toEmailOtpResentSuccessfully({
    required String email,
  }) =>
      EmailOtpResentSuccessfully.fromState(state: this, email: email);
}

final class LoginInitial extends LoginState {
  LoginInitial({
    bool? isObscured,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    GlobalKey<FormState>? formKey,
    GlobalKey<FormFieldState>? emailFieldKey,
  }) : super(
            isObscured: isObscured ?? true,
            formKey: formKey ?? GlobalKey<FormState>(),
            emailFieldKey: emailFieldKey ?? GlobalKey<FormFieldState>(),
            emailController: emailController ?? TextEditingController(),
            passwordController: passwordController ?? TextEditingController());
}

final class LoginSuccessful extends LoginState {
  LoginSuccessful.fromState({
    required LoginState state,
  }) : super(
          isObscured: state.isObscured,
          emailController: state.emailController,
          passwordController: state.passwordController,
          formKey: state.formKey,
          emailFieldKey: state.emailFieldKey,
        );
}

final class LoginFailed extends LoginState {
  LoginFailed.fromState({
    required LoginState state,
  }) : super(
          isObscured: state.isObscured,
          emailController: state.emailController,
          passwordController: state.passwordController,
          formKey: state.formKey,
          emailFieldKey: state.emailFieldKey,
        );
}

final class LoginLoading extends LoginState {
  LoginLoading.fromState({
    required LoginState state,
  }) : super(
          isObscured: state.isObscured,
          emailController: state.emailController,
          passwordController: state.passwordController,
          formKey: state.formKey,
          emailFieldKey: state.emailFieldKey,
        );
}

final class LoadingUsersDone extends LoginState {
  LoadingUsersDone.fromState({
    required LoginState state,
  }) : super(
          isObscured: state.isObscured,
          emailController: state.emailController,
          passwordController: state.passwordController,
          formKey: state.formKey,
          emailFieldKey: state.emailFieldKey,
        );
}

final class LoadingUsers extends LoginState {
  LoadingUsers.fromState({
    required LoginState state,
  }) : super(
          isObscured: state.isObscured,
          emailController: state.emailController,
          passwordController: state.passwordController,
          formKey: state.formKey,
          emailFieldKey: state.emailFieldKey,
        );
}

final class LoadingUsersFailed extends LoginState {
  LoadingUsersFailed.fromState({
    required LoginState state,
  }) : super(
          isObscured: state.isObscured,
          emailController: state.emailController,
          passwordController: state.passwordController,
          formKey: state.formKey,
          emailFieldKey: state.emailFieldKey,
        );
}

final class PasswordVisibilityChanged extends LoginState {
  PasswordVisibilityChanged.fromState({
    required LoginState state,
    required super.isObscured,
  }) : super(
            formKey: state.formKey,
            emailFieldKey: state.emailFieldKey,
            emailController: state.emailController,
            passwordController: state.passwordController);
}

final class LoggedOut extends LoginState {
  LoggedOut.fromState({
    required LoginState state,
  }) : super(
          isObscured: state.isObscured,
          emailController: state.emailController,
          passwordController: state.passwordController,
          formKey: state.formKey,
          emailFieldKey: state.emailFieldKey,
        );
}

final class ForgotPassword extends LoginState {
  ForgotPassword.fromState({
    required LoginState state,
  }) : super(
          isObscured: state.isObscured,
          emailController: state.emailController,
          passwordController: state.passwordController,
          formKey: state.formKey,
          emailFieldKey: state.emailFieldKey,
        );
}

final class EmailOtpResentSuccessfully extends LoginState {
  final String email;

  EmailOtpResentSuccessfully.fromState({
    required LoginState state,
    required this.email,
  }) : super(
          isObscured: state.isObscured,
          emailController: state.emailController,
          passwordController: state.passwordController,
          formKey: state.formKey,
          emailFieldKey: state.emailFieldKey,
        );
}
