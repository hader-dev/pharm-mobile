import '../../../models/user.dart';

abstract class IUserRepository {
  Future<String> login(
    String username,
    String password,
  );
  Future<String> emailSignUp(
    String email,
    String fullName,
    String password,
  );
  Future<UserModel> getCurrentUserData();
  Future<void> changePassword({required String oldPassword, required String newPassword});
}
