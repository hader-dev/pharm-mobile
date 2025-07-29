import 'package:bloc/bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';

import 'package:flutter/material.dart';

import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../../../../utils/app_exceptions/global_expcetion_handler.dart';

import '../../../../../utils/app_exceptions/exceptions.dart';
import '../../../../config/routes/routing_manager.dart' show RoutingManager;
import '../../../../utils/toast_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  bool isObscured = true;

  TextEditingController emailController = TextEditingController(text: "ayoub1@gmail.com");

  TextEditingController passwordController = TextEditingController(text: "Strong@12");

  LoginCubit() : super(LoginInitial());

  Future<void> login(String userName, String password) async {
    try {
      emit(LoginLoading());
      // ignore: unused_local_variable
      var token = await getItInstance.get<UserManager>().login(userName: userName, password: password);
      emit(LoginSuccessful());
    } on UnAuthorizedException catch (e) {
      if (e.errorCode == ApiErrorCodes.EMAIL_NOT_VERIFIED.name) {
        getItInstance.get<ToastManager>().showToast(
              type: ToastType.warning,
              message: RoutingManager.rootNavigatorKey.currentContext!.translation!.email_not_verified,
            );
        resendEmailOtp(emailController.text);
      }
      GlobalExceptionHandler.handle(
        exception: e,
      );
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handle(exception: e, exceptionStackTrace: stackTrace);

      emit(LoginFailed());
    }
  }

  void forgetPassword() async {
    try {
      await getItInstance.get<UserManager>().sendResetPasswordMail(email: emailController.text);
      emit(ResetLinkSent());
    } catch (e) {
      GlobalExceptionHandler.handle(
        exception: e,
      );
    }
  }

  resendEmailOtp(String email) async {
    try {
      await getItInstance.get<UserManager>().resendOtpCode(email: email);
      emit(EmailOtpResentSuccessfully(email: email));
    } catch (e) {
      GlobalExceptionHandler.handle(
        exception: e,
      );
    }
  }

  void showPassword() {
    isObscured = !isObscured;
    emit(PasswordVisibilityChanged());
  }
}
