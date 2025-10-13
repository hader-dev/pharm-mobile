part of 'edit_profile_cubit.dart';

sealed class EditProfileState {
  UserModel userData;
  EditProfileFormDataModel profileData;
  XFile? pickedImage;
  bool shouldRemoveImage;

  EditProfileState({
    required this.userData,
    required this.profileData,
    this.pickedImage,
    this.shouldRemoveImage = false,
  });

  EditProfileLoading toLoading() => EditProfileLoading.fromState(state: this);

  EditProfileSuccess toSuccess({
    required EditProfileFormDataModel profileData,
    required UserModel userData,
  }) =>
      EditProfileSuccess.fromState(
          state: this, profileData: profileData, userData: userData);

  ProfileDataLoaded toProfileDataLoaded({
    required EditProfileFormDataModel profileData,
  }) =>
      ProfileDataLoaded.fromState(state: this, profileData: profileData);

  EditProfileFailed toFailed() => EditProfileFailed.fromState(state: this);

  UserImagePicked toUserImagePicked(
          {XFile? pickedImage, required bool shouldRemoveImage}) =>
      UserImagePicked.fromState(
          state: this,
          pickedImage: pickedImage,
          shouldRemoveImage: shouldRemoveImage);
}

final class EditProfileInitial extends EditProfileState {
  EditProfileInitial({
    super.pickedImage,
    EditProfileFormDataModel? profileData,
    UserModel? userData,
    super.shouldRemoveImage,
  }) : super(
            userData: userData ?? UserModel.empty(),
            profileData: profileData ?? EditProfileFormDataModel());
}

final class EditProfileLoading extends EditProfileInitial {
  EditProfileLoading.fromState({required EditProfileState state})
      : super(
            userData: state.userData,
            profileData: state.profileData,
            pickedImage: state.pickedImage,
            shouldRemoveImage: state.shouldRemoveImage);
}

final class EditProfileSuccess extends EditProfileInitial {
  EditProfileSuccess.fromState({
    required EditProfileState state,
    required EditProfileFormDataModel profileData,
    required UserModel userData,
  }) : super(
            userData: userData,
            profileData: profileData,
            pickedImage: state.pickedImage,
            shouldRemoveImage: state.shouldRemoveImage);
}

final class ProfileDataLoaded extends EditProfileInitial {
  ProfileDataLoaded.fromState(
      {required EditProfileState state,
      required EditProfileFormDataModel profileData})
      : super(
            userData: state.userData,
            profileData: profileData,
            pickedImage: state.pickedImage,
            shouldRemoveImage: state.shouldRemoveImage);
}

final class EditProfileFailed extends EditProfileInitial {
  EditProfileFailed.fromState({required EditProfileState state})
      : super(
            userData: state.userData,
            profileData: state.profileData,
            pickedImage: state.pickedImage,
            shouldRemoveImage: state.shouldRemoveImage);
}

final class UserImagePicked extends EditProfileInitial {
  UserImagePicked.fromState(
      {required EditProfileState state,
      super.pickedImage,
      required super.shouldRemoveImage})
      : super(userData: state.userData, profileData: state.profileData);
}
