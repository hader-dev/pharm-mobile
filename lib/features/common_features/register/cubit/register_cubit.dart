import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/register/hooks_data_model/register_email_form.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';
import 'package:hader_pharm_mobile/utils/device_gallery_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';
import 'package:image_picker/image_picker.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final UserManager userManager;
  RegisterCubit({required this.userManager}) : super(RegisterInitial());

  void emailRegister(EmailRegisterFormDataModel formData,
      [String? token]) async {
    try {
      emit(state.toLoading());
      await userManager.emailSignUp(
          email: formData.email,
          fullName: formData.fullName,
          password: formData.password,
          token: token,
          userImagePath: state.pickedImage?.path);
      getItInstance.get<ToastManager>().showToast(
          message: RoutingManager.rootNavigatorKey.currentContext!.translation!
              .check_email_for_verification,
          type: ToastType.success);

      emit(state.toSuccess(email: formData.email));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.toFailed());
    }
  }

  void changeTab(int index) {
    emit(state.toTapChanged(
      selectedTapIndex: index,
    ));
  }

  Future<void> pickUserImage() async {
    try {
      final pickedImage = await DeviceGalleryHelper.pickImageFromGallery();
      if (pickedImage != null) {
        emit(state.toImagePicked(
          shouldRemoveImage: true,
          pickedImage: pickedImage,
        ));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void showPassword() {
    emit(state.toPasswordVisibilityChanged(
      isObscured: !state.isObscured,
    ));
  }

  void removeImage() {
    emit(state.toImagePicked(
      shouldRemoveImage: false,
      pickedImage: null,
    ));
  }

  void updateFormData(EmailRegisterFormDataModel formData) {
    emit(state.toUpdateFormData(
      formData: formData,
    ));
  }
}
