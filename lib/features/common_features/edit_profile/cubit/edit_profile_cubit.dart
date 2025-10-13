import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/edit_profile/hooks_data_model/edit_profile_form.dart';
import 'package:hader_pharm_mobile/models/user.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';
import 'package:hader_pharm_mobile/utils/device_gallery_helper.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';
import 'package:image_picker/image_picker.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final UserManager userManager;

  EditProfileCubit({required this.userManager}) : super(EditProfileInitial());

  Future<void> initProfileData() async {
    try {
      emit(state.toLoading());
      final currentUser = getItInstance.get<UserManager>().currentUser;

      final profileData = state.profileData.copyWith(
        email: currentUser.email,
        fullName: currentUser.fullName,
        phone: currentUser.phone,
        address: currentUser.address,
        imagePath: currentUser.image?.filename,
      );
      emit(state.toSuccess(profileData: profileData, userData: currentUser));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.toFailed());
    }
  }

  void editProfile(EditProfileFormDataModel formData) async {
    try {
      emit(state.toLoading());

      if (state.pickedImage != null) {
        formData = formData.copyWith(imagePath: state.pickedImage?.path);
      }

      await userManager.updateProfile(
        updatedProfileData: formData,
        shouldRemoveImage: state.shouldRemoveImage,
      );

      await _refreshUserData();

      getItInstance.get<ToastManager>().showToast(
          message: "Profile updated successfully", type: ToastType.success);

      emit(state.toUserImagePicked(
        shouldRemoveImage: false,
        pickedImage: null,
      ));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.toFailed());
    }
  }

  Future<void> _refreshUserData() async {
    try {
      await getItInstance.get<UserManager>().getMe();
    } catch (e) {
      debugPrint('Error refreshing user data: $e');
    }
  }

  Future<void> pickUserImage() async {
    try {
      final pickedImage = await DeviceGalleryHelper.pickImageFromGallery();
      if (pickedImage != null) {
        emit(state.toUserImagePicked(
          shouldRemoveImage: false,
          pickedImage: pickedImage,
        ));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void changeProfileData({required EditProfileFormDataModel modifiedData}) {
    emit(state.toProfileDataLoaded(profileData: modifiedData));
  }

  void removeImage() {
    emit(state.toUserImagePicked(
      shouldRemoveImage: true,
      pickedImage: null,
    ));
  }
}
