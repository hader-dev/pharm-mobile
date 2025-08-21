part of 'edit_profile_cubit.dart';

sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}

final class EditProfileLoading extends EditProfileState {}

final class EditProfileSuccuss extends EditProfileState {}

final class ProfileDataLoaded extends EditProfileState {}

final class EditProfileFailed extends EditProfileState {}

//User Image Picked
final class UserImagePicked extends EditProfileState {}
