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

  Future<void> getMe() async {
    final UserModel userData = await userRepo.getCurrentUserData();
    currentUser = userData;
  }

  Future<void> logout() async {
    await tokenManagerInstance.removeToken();
  }
}
