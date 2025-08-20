import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/models/user.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../config/services/auth/user_manager.dart';
import '../../../../utils/device_gallery_helper.dart';
import '../hooks_data_model/edit_profile_form.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final UserManager userManager;
  UserModel? userData;
  EditProfileFormDataModel profileData = EditProfileFormDataModel();
  XFile? pickedImage;
  bool shouldRemoveImage = false; // Track if user wants to remove existing image

  EditProfileCubit({required this.userManager}) : super(EditProfileInitial());

  initProfileData() async {
    try {
      emit(EditProfileLoading());

      profileData = profileData.copyWith(
        email: getItInstance.get<UserManager>().currentUser.email,
        fullName: getItInstance.get<UserManager>().currentUser.fullName,
        phone: getItInstance.get<UserManager>().currentUser.phone,
        address: getItInstance.get<UserManager>().currentUser.address,
        imagePath: getItInstance.get<UserManager>().currentUser.image?.filename,
      );
      emit(EditProfileSuccuss());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(EditProfileFailed());
    }
  }

  void editProfile(EditProfileFormDataModel formData) async {
    try {
      emit(EditProfileLoading());

      if (pickedImage != null) {
        debugPrint("Profile update: Image selected - ${pickedImage?.path}");
        formData = formData.copyWith(imagePath: pickedImage?.path);
      } else {
        debugPrint("Profile update: No image selected");
      }

      debugPrint("Profile update: Form data - ${formData.toString()}");

      await userManager.updateProfile(
        updatedProfileData: formData,
        shouldRemoveImage: shouldRemoveImage,
      );
      await getItInstance.get<UserManager>().getMe();

      // Reset flags after successful update
      shouldRemoveImage = false;
      pickedImage = null;

      getItInstance
          .get<ToastManager>()
          .showToast(message: "Update successful", type: ToastType.success);

      emit(EditProfileSuccuss());
    } catch (e) {
      debugPrint("Profile update error: $e");
      if (e.toString().contains('runtimeType')) {
        debugPrint("Error type: ${e.runtimeType}");
      }
      GlobalExceptionHandler.handle(exception: e);
      emit(EditProfileFailed());
    }
  }

  Future<void> pickUserImage() async {
    try {
      pickedImage = await DeviceGalleryHelper.pickImageFromGallery();
      if (pickedImage != null) {
        shouldRemoveImage = false; // User selected new image, don't remove existing one
        emit(UserImagePicked());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  changeProfileData({required EditProfileFormDataModel modifiedData}) {
    debugPrint(profileData.toString());
    profileData = modifiedData;
    emit(ProfileDataChanged());
  }

  void removeImage() {
    pickedImage = null;
    shouldRemoveImage = true; // User wants to remove existing image
    emit(UserImagePicked());
  }
}
