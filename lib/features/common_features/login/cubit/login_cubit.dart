import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/exceptions.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';

import '../actions/setup_company_or_go_home.dart' show setupCompanyOrSkipToHome;

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String userName, String password) async {
    try {
      emit(state.toLoginLoading());
      // ignore: unused_local_variable
      var token = await getItInstance.get<UserManager>().login(userName: userName, password: password);
      emit(state.toLoginSuccessful());
    } on UnAuthorizedException catch (e) {
      if (e.errorCode == ApiErrorCodes.UNAUTHORIZED_DISTRIBUTOR_LOGIN.name) {
        getItInstance.get<ToastManager>().showToast(
              type: ToastType.warning,
              message: RoutingManager.rootNavigatorKey.currentContext!.translation!.unauthorized_distributor_login,
            );
      }
      if (e.errorCode == ApiErrorCodes.EMAIL_NOT_VERIFIED.name) {
        RoutingManager.router.pushNamed(RoutingManager.checkEmailScreen, extra: {
          "email": state.emailController.text,
          "autoRedirect": true,
        });
      }
      GlobalExceptionHandler.handle(
        exception: e,
      );

      emit(state.toLoginFailed());
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handle(exception: e, exceptionStackTrace: stackTrace);

      emit(state.toLoginFailed());
    }
  }

  void forgetPassword() async {
    emit(state.toForgotPassword());
  }

  Future<void> resendEmailOtp(String email) async {
    try {
      await getItInstance.get<UserManager>().resendOtpCode(email: email);
      emit(state.toEmailOtpResentSuccessfully(email: email));
    } catch (e) {
      GlobalExceptionHandler.handle(
        exception: e,
      );
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      emit(state.toGoogleLoginLoading());
      await getItInstance.get<UserManager>().googleSignIn();
      setupCompanyOrSkipToHome();
    } catch (e) {
      GlobalExceptionHandler.handle(
        exception: e,
      );
      RoutingManager.router.pushNamed(
        RoutingManager.loginScreen,
      );
    }
  }

  void showPassword() {
    emit(state.toPasswordVisibilityChanged(
      isObscured: !state.isObscured,
    ));
  }
}
