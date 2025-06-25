import '../../../models/user.dart';

abstract class IUserRepository {
  Future<UserModel> getCurrentUserData();
  Future<String> login(
    String username,
    String password,
  );
  Future<String> emailSignUp(String email, String fullName, String password, {String? userImagePath});
  Future<void> changePassword({required String oldPassword, required String newPassword});
  Future<String> checkUserEmail({required String email, required String otp});
  Future<void> resendOtp({required String email});
  Future<void> sendResetPasswordMail({required String email});
}
