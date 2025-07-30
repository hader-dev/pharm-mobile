import 'package:bloc/bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';

import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';


part 'forgot_pasword_state.dart';

bool testWithAccountOne = true;
class ForgotPasswordCubit extends Cubit<ForgotPaswordState> {
  bool isObscured = true;

  TextEditingController emailController = TextEditingController(text: testWithAccountOne ? "ayoub1@gmail.com" : "nocompany@gmail.com");

  ForgotPasswordCubit() : super(ForgotPasswordInitial());

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

}
