import '../../../features/common_features/edit_profile/hooks_data_model/edit_profile_form.dart'
    show EditProfileFormDataModel;
import '../../../models/user.dart';

abstract class IUserRepository {
  Future<UserModel> getCurrentUserData();
  Future<String> login(
    String username,
    String password,
  );
  Future<String> emailSignUp(String email, String fullName, String password, {String? userImagePath});
  Future<void> changePassword({required String currentPassword, required String newPassword});
  Future<String> sendUserEmailCheckOtpCode({required String email, required String otp});
  Future<void> resendOtp({required String email});
  Future<void> sendResetPasswordMail({required String email});
  Future<void> updateProfile({required EditProfileFormDataModel updatedProfileData, bool shouldRemoveImage = false});
}
