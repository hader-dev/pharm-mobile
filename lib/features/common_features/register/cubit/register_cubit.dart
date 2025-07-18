import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../config/routes/routing_manager.dart' show RoutingManager;
import '../../../../config/services/auth/user_manager.dart';
import '../../../../utils/device_gallery_helper.dart';
import '../hooks_data_model/register_email_form.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  int selectedTapIndex = 0;
  bool isObscured = true;
  final UserManager userManager;
  XFile? pickedImage;
  RegisterCubit({required this.userManager}) : super(RegisterInitial());

  void emailRegister(EmailRegisterFormDataModel formData) async {
    try {
      emit(RegisterLoading());
      await userManager.emailSignUp(
          email: formData.email,
          fullName: formData.fullName,
          password: formData.password,
          userImagePath: pickedImage?.path);
      getItInstance.get<ToastManager>().showToast(
          message: RoutingManager.rootNavigatorKey.currentContext!.translation!.registrationSuccess,
          type: ToastType.success);
      await Future.delayed(const Duration(seconds: 1), () {
        getItInstance.get<ToastManager>().showToast(
            message: RoutingManager.rootNavigatorKey.currentContext!.translation!.checkEmailForVerification,
            type: ToastType.success);
      });
      emit(RegisterSuccuss(email: formData.email));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(RegisterFailed());
    }
  }

  changeTab(int index) {
    selectedTapIndex = index;
    emit(TapChanged());
  }

  Future<void> pickUserImage() async {
    try {
      pickedImage = await DeviceGalleryHelper.pickImageFromGallery();
      if (pickedImage != null) {
        emit(UserImagePicked());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void showPassword() {
    isObscured = !isObscured;
    emit(PasswordVisibilityChanged());
  }

  void removeImage() {
    pickedImage = null;
    emit(UserImagePicked());
  }
}
