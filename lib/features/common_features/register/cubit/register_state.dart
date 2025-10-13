part of 'register_cubit.dart';

sealed class RegisterState {
  final int selectedTapIndex;
  final bool isObscured;
  final XFile? pickedImage;
  final GlobalKey<FormState> formKey;
  final EmailRegisterFormDataModel formData;

  const RegisterState(
      {required this.selectedTapIndex,
      required this.isObscured,
      required this.formKey,
      required this.formData,
      this.pickedImage});

  RegisterLoading toLoading() => RegisterLoading.fromState(state: this);

  RegisterFailed toFailed() => RegisterFailed.fromState(state: this);

  RegisterSuccess toSuccess({required String email}) =>
      RegisterSuccess.fromState(state: this, email: email);

  PasswordVisibilityChanged toPasswordVisibilityChanged(
          {required bool isObscured}) =>
      PasswordVisibilityChanged.fromState(state: this, isObscured: isObscured);

  UserImagePicked toImagePicked(
      {required bool shouldRemoveImage, required XFile? pickedImage}) {
    return UserImagePicked.fromState(
      state: this,
      shouldRemoveImage: shouldRemoveImage,
      pickedImage: pickedImage,
    );
  }

  TapChanged toTapChanged({required int selectedTapIndex}) =>
      TapChanged.fromState(state: this, selectedTapIndex: selectedTapIndex);

  UpdateFormData toUpdateFormData(
          {required EmailRegisterFormDataModel formData}) =>
      UpdateFormData.fromState(state: this, formData: formData);
}

final class RegisterInitial extends RegisterState {
  RegisterInitial({
    int? selectedTapIndex,
    GlobalKey<FormState>? formKey,
    EmailRegisterFormDataModel? formData,
    bool? isObscured,
    super.pickedImage,
  }) : super(
          formKey: formKey ?? GlobalKey<FormState>(),
          formData: formData ?? EmailRegisterFormDataModel(),
          selectedTapIndex: selectedTapIndex ?? 0,
          isObscured: isObscured ?? true,
        );
}

final class RegisterLoading extends RegisterState {
  RegisterLoading.fromState({
    required RegisterState state,
  }) : super(
          selectedTapIndex: state.selectedTapIndex,
          isObscured: state.isObscured,
          pickedImage: state.pickedImage,
          formKey: state.formKey,
          formData: state.formData,
        );
}

final class UpdateFormData extends RegisterState {
  UpdateFormData.fromState({
    required RegisterState state,
    required super.formData,
  }) : super(
          selectedTapIndex: state.selectedTapIndex,
          isObscured: state.isObscured,
          pickedImage: state.pickedImage,
          formKey: state.formKey,
        );
}

final class RegisterSuccess extends RegisterState {
  final String email;

  RegisterSuccess.fromState({
    required this.email,
    required RegisterState state,
  }) : super(
          selectedTapIndex: state.selectedTapIndex,
          isObscured: state.isObscured,
          pickedImage: state.pickedImage,
          formKey: state.formKey,
          formData: state.formData,
        );
}

final class RegisterFailed extends RegisterState {
  RegisterFailed.fromState({
    required RegisterState state,
  }) : super(
          selectedTapIndex: state.selectedTapIndex,
          isObscured: state.isObscured,
          pickedImage: state.pickedImage,
          formKey: state.formKey,
          formData: state.formData,
        );
}

//Password visibility changed
final class PasswordVisibilityChanged extends RegisterState {
  PasswordVisibilityChanged.fromState({
    required RegisterState state,
    required super.isObscured,
  }) : super(
          selectedTapIndex: state.selectedTapIndex,
          pickedImage: state.pickedImage,
          formKey: state.formKey,
          formData: state.formData,
        );
}

//Tap chanage state
final class TapChanged extends RegisterState {
  TapChanged.fromState({
    required RegisterState state,
    required super.selectedTapIndex,
  }) : super(
          isObscured: state.isObscured,
          pickedImage: state.pickedImage,
          formKey: state.formKey,
          formData: state.formData,
        );
}

//User Image Picked
final class UserImagePicked extends RegisterState {
  UserImagePicked.fromState({
    required RegisterState state,
    required super.pickedImage,
    required bool shouldRemoveImage,
  }) : super(
          selectedTapIndex: state.selectedTapIndex,
          isObscured: state.isObscured,
          formKey: state.formKey,
          formData: state.formData,
        );
}
