import 'dart:async' show Timer;

import 'package:bloc/bloc.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';

import '../../../../config/di/di.dart';
import '../../../../config/services/auth/user_manager.dart';
import '../../../../utils/toast_helper.dart';

part 'check_email_state.dart';

class CheckEmailCubit extends Cubit<CheckEmailState> {
  late final String userEmail;
  final UserManager userManager;
  bool isResendActive = true;
  CheckEmailCubit({required this.userManager}) : super(CheckEmailInitial());

  initEmail(String email) {
    userEmail = email;
    emit(InitEmail());
  }

  void checkEmail(String otp) async {
    try {
      emit(CheckEmailLoading());
      await userManager.checkUserEmailOtp(email: userEmail, otp: otp);
      getItInstance
          .get<ToastManager>()
          .showToast(message: "Verification successful for $userEmail ", type: ToastType.success);
      emit(CheckEmailSuccuss());
    } catch (e) {
      emit(CheckEmailFailed());
    }
  }

  resendOtp(String email) async {
    try {
      emit(resendOtpLoading());
      await userManager.resendOtpCode(email: userEmail);
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
      emit(CheckEmailFailed());
    }
  }
}
