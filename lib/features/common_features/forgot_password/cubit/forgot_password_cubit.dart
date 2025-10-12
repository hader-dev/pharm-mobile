import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/language_config/resources/app_localizations.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/login/actions/setup_company_or_go_home.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';

part 'forgot_pasword_state.dart';

bool testWithAccountOne = true;

class ForgotPasswordCubit extends Cubit<ForgotPaswordState> {
  bool isObscured = true;
  bool isResendActive = true;
  final UserManager userManager;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormFieldState> passwordFieldKey = GlobalKey<FormFieldState>();

  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController newPasswordController = TextEditingController(text: "");

  ForgotPasswordCubit({
    required this.userManager,
  }) : super(ForgotPasswordInitial());

  void forgetPassword() async {
    try {
      await getItInstance
          .get<UserManager>()
          .sendResetPasswordMail(email: emailController.text);
      emit(ResetLinkSent());
    } catch (e) {
      GlobalExceptionHandler.handle(
        exception: e,
      );
    }
  }

  Future<void> resendOtp() async {
    try {
      emit(ResendOtpLoading());
      await userManager.resendOtpCode(email: emailController.text);
      int counter = 10;
      Timer.periodic(const Duration(seconds: 1), (timer) {
        isResendActive = false;
        counter--;
        if (counter == 0) {
          timer.cancel();
          isResendActive = true;
        }
        emit(TimerCountChanged(count: counter));
      });
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
    }
  }

  Future<void> resetPassword(String otp, AppLocalizations translation) async {
    try {
      if (formKey.currentState!.validate()) {
        await userManager.forgotPassword(
            email: emailController.text,
            otp: otp,
            newPassword: newPasswordController.text);

        final success = await getItInstance.get<UserManager>().login(
            userName: emailController.text,
            password: newPasswordController.text);

        if (success) {
          setupCompanyOrSkipToHome();
        }
        _reset();
        emit(ResetPasswordSuccess());
      }
    } catch (e) {
      debugPrint("$e");
      GlobalExceptionHandler.handle(exception: e);
    }
  }

  void _reset() {
    emailController.clear();
    newPasswordController.clear();
  }

  void navigateBack() {
    _reset();
    emit(ForgotPasswordInitial());
  }

  void showPassword() {
    isObscured = !isObscured;
    emit(PasswordVisibilityChanged());
  }
}
