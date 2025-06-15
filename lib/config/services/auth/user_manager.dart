import 'package:win32/win32.dart';

import '../../../models/user.dart';
import '../../../repositories/remote/user/user_repository_impl.dart';
import '../../di/di.dart';
import '../network/dio/dio_network_manager.dart';
import '../network/network_interface.dart';
import 'token_manager.dart';

//TODO:I need to refactore this class
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
  }) async {
    await userRepo.emailSignUp(email, fullName, password);
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

  /// Logs out the current user by removing the stored authentication token.
  ///
  /// This method clears the token from [TokenManager], effectively logging out the user.

  Future<void> logout() async {
    await tokenManagerInstance.removeToken();
  }
}
