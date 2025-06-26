import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';

import '../../../../config/di/di.dart';
import '../../../../utils/app_exceptions/global_expcetion_handler.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  bool isObscured = true;

  late bool isLogin;
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  ChangePasswordCubit() : super(ChangePasswordInitial());
  void showPassword() {
    isObscured = !isObscured;
    emit(PasswordVisibilityChanged());
  }

  Future<void> changePassword() async {
    try {
      emit(ChangePasswordLoading());
      await getItInstance.get<UserManager>().changePassword(
            currentPassword: currentPasswordController.text,
            newPassword: newPasswordController.text,
          );
      currentPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();

      emit(ChangePasswordSuccessful());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(ChangePasswordFailed());
    }
  }

  @override
  Future<void> close() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
