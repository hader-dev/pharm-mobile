import 'package:hader_pharm_mobile/features/common_features/edit_profile/hooks_data_model/edit_profile_form.dart';

import '../../../models/user.dart';
import '../../../repositories/remote/user/user_repository_impl.dart';
import '../../di/di.dart';
import '../network/dio/dio_network_manager.dart';
import '../network/network_interface.dart';
import 'token_manager.dart';

class UserManager {
  static late UserRepository userRepo;
  late UserModel currentUser;
  static late TokenManager tokenManagerInstance;
  static final UserManager _instance = UserManager._internal();
  static UserManager get instance => _instance;

  UserManager._internal();
  static UserManager init({required UserRepository userRepository, required TokenManager tokenManager}) {
    userRepo = userRepository;
    tokenManagerInstance = tokenManager;
    return _instance;
  }

  /// Registers a new user with the provided email, full name and password.
  Future<void> emailSignUp({
    required String email,
    required String fullName,
    required String password,
    String? userImagePath,
  }) async {
    await userRepo.emailSignUp(email, fullName, password, userImagePath: userImagePath);
  }

  /// Resends the OTP code for the given email.
  ///
  /// This method is used when the user requests to resend the OTP code.
  ///
  Future<void> resendOtpCode({
    required String email,
  }) async {
    await userRepo.resendOtp(
      email: email,
    );
  }

  /// Logs in a user with the provided username and password.
  ///
  /// After a successful login, this method stores the received token in the
  /// [TokenManager] and initializes the default headers in the [DioNetworkManager]
  /// with the token. Additionally, it calls [getMe] to update the [currentUser].
  ///
  /// Returns `true` on success.
  Future<bool> login({
    required String userName,
    required String password,
  }) async {
    final String token = await userRepo.login(userName, password);
    await tokenManagerInstance.storeAccessToken(token);
    (getItInstance.get<INetworkService>() as DioNetworkManager).initDefaultHeaders(token);
    await getMe();
    return true;
  }

  /// Gets the current user's data and updates the [currentUser].
  ///
  /// This method is used to update the [currentUser] after a successful login.

  Future<void> getMe() async {
    final UserModel userData = await userRepo.getCurrentUserData();
    currentUser = userData;
  }

  /// Checks the provided OTP for the given email.
  ///
  /// This method is used in the "check email" feature to verify the OTP sent to the
  /// user's email.
  ///
  /// Returns `true` on success.
  Future<void> sendUserEmailCheckOtpCode({
    required String email,
    required String otp,
  }) async {
    String token = await userRepo.sendUserEmailCheckOtpCode(email: email, otp: otp);
    await tokenManagerInstance.storeAccessToken(token);
    (getItInstance.get<INetworkService>() as DioNetworkManager).initDefaultHeaders(token);
  }

  Future<void> sendResetPasswordMail({
    required String email,
  }) async {
    await userRepo.sendResetPasswordMail(
      email: email,
    );
  }

  /// Changes the password for the current user.
  ///
  /// This method is used in the "change password" feature to update the user's
  /// password.
  ///
  /// Returns `true` on success.
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await userRepo.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }

  ///Updates the current user profile data.
  Future<void> updateProfile({
    required EditProfileFormDataModel updatedProfileData,
  }) async {
    await userRepo.updateProfile(updatedProfileData: updatedProfileData);
  }

  /// Logs out the current user by removing the stored authentication token.
  ///
  /// This method clears the token from [TokenManager], effectively logging out the user.

  Future<void> logout() async {
    await tokenManagerInstance.removeToken();
  }
}
