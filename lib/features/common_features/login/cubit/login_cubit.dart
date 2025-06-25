import 'package:bloc/bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../../../utils/app_exceptions/global_expcetion_handler.dart';

import '../../../../../repositories/remote/user/user_repository_impl.dart';
import '../../../../../utils/app_exceptions/exceptions.dart';
import '../../../../utils/toast_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  bool isObscured = true;

  TextEditingController userNameController = TextEditingController(text: "mail4@mail.com");
  TextEditingController passwordController = TextEditingController(text: "Strong@12");

  final UserRepository userRepository;

  LoginCubit({required this.userRepository}) : super(LoginInitial());

  Future<void> login(String userName, String password) async {
    try {
      emit(LoginLoading());
      var token = await getItInstance.get<UserManager>().login(userName: userName, password: password);
      emit(LoginSuccessful());
    } catch (e, stackTrace) {
      GlobalExceptionHandler.handle(exception: e, exceptionStackTrace: stackTrace);
      emit(LoginFailed());
    }
  }

  void forgetPassword() async {
    try {
      await getItInstance.get<UserManager>().sendResetPasswordMail(email: userNameController.text);
      emit(ResetLinkSent());
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
