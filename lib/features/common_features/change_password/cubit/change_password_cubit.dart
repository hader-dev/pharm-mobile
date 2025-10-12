import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());
  void showPassword() {
    emit(state.toPasswordVisibilityChanged());
  }

  Future<void> changePassword() async {
    try {
      emit(state.toChangePasswordLoading());
      await getItInstance.get<UserManager>().changePassword(
            currentPassword: state.currentPasswordController.text,
            newPassword: state.newPasswordController.text,
          );
      state.currentPasswordController.clear();
      state.newPasswordController.clear();
      state.confirmPasswordController.clear();

      emit(state.toPasswordUpdateSuccess());
    } catch (e) {
      debugPrint(e.toString());
      emit(state.toPasswordUpdatedFailed());
    }
  }

  @override
  Future<void> close() {
    state.currentPasswordController.dispose();
    state.newPasswordController.dispose();
    state.confirmPasswordController.dispose();
    return super.close();
  }
}
