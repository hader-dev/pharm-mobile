import '../../../models/user.dart';

abstract class IUserRepository {
  Future<String> login(
    String username,
    String password,
  );
  Future<String> emailSignUp(String email, String fullName, String password, {String? userImagePath});
  Future<UserModel> getCurrentUserData();
  Future<void> changePassword({required String oldPassword, required String newPassword});
  Future<String> checkUserEmail({required String email, required String otp});
}
