import 'dart:async' show Timer;

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/language_config/resources/app_localizations.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';

part 'check_email_state.dart';

class CheckEmailCubit extends Cubit<CheckEmailState> {
  final UserManager userManager;
  CheckEmailCubit({required this.userManager}) : super(CheckEmailInitial());

  void initEmail(String email) {
    emit(state.initEmail(email: email));
  }

  void checkEmail(String otp, AppLocalizations translation) async {
    final toastManager = getItInstance.get<ToastManager>();

    try {
      emit(state.loading());
      await userManager.sendUserEmailCheckOtpCode(
          email: state.userEmail, otp: otp);
      toastManager.showToast(
          message:
              "${translation.verification_successful_for} ${state.userEmail} ",
          type: ToastType.success);
      emit(state.success());
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: stackTrace);
      toastManager.showToast(
          message: translation.feedback_action_failed, type: ToastType.error);
      emit(state.failed());
    }
  }

  Future<void> resendOtp(String email) async {
    try {
      emit(state.loading());
      await userManager.resendOtpCode(email: state.userEmail);
      int counter = 10;
      bool isResendActive = false;
      Timer.periodic(const Duration(seconds: 1), (timer) {
        isResendActive = false;
        counter--;
        if (counter == 0) {
          timer.cancel();
          isResendActive = true;
        }
        emit(state.counterTicked(
            count: counter, isResendActive: isResendActive));
      });
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: stack);
      GlobalExceptionHandler.handle(exception: e);
      emit(state.failed());
    }
  }
}
