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
  final UserManager userManager;

  List<TextEditingController?> otpControllers = [];

  ForgotPasswordCubit({
    required this.userManager,
  }) : super(ForgotPasswordInitial());

  void forgetPassword() async {
    try {
      await getItInstance
          .get<UserManager>()
          .sendResetPasswordMail(email: state.emailController.text);
      emit(state.toResetLinkSent());
    } catch (e) {
      debugPrint("$e");
      GlobalExceptionHandler.handle(
        exception: e,
      );
      emit(state.toError());
    }
  }

  Future<void> resendOtp() async {
    try {
      emit(state.toResendOtpLoading());
      await userManager.resendOtpCode(email: state.emailController.text);
      int counter = 10;
      Timer.periodic(const Duration(seconds: 1), (timer) {
        bool isResendActive = false;
        counter--;
        if (counter == 0) {
          timer.cancel();
          isResendActive = true;
        }
        emit(state.toCounterTicked(
            count: counter, isResendActive: isResendActive));
      });
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.toError());
    }
  }

  Future<void> resetPassword(String otp, AppLocalizations translation) async {
    try {
      if (state.formKey.currentState!.validate()) {
        emit(state.toResetPasswordLoading());
        await userManager.forgotPassword(
            email: state.emailController.text,
            otp: otp,
            newPassword: state.newPasswordController.text);

        final success = await getItInstance.get<UserManager>().login(
            userName: state.emailController.text,
            password: state.newPasswordController.text);

        if (success) {
          setupCompanyOrSkipToHome();
        }
        _reset();
        emit(state.toResetPasswordSuccess());
      }
    } catch (e) {
      debugPrint("$e");
      GlobalExceptionHandler.handle(exception: e);
      emit(state.toError());
    }
  }

  void _reset() {
    state.emailController.clear();
    state.newPasswordController.clear();

    emit(state.toInitial());
  }

  void navigateBack() {
    _reset();
  }

  void showPassword() {
    emit(state.toPasswordVisibilityChanged(
      isObscured: !state.isObscured,
    ));
  }

  void setupOtpControllers(List<TextEditingController?> controllers) {
    otpControllers = controllers;
  }
}
