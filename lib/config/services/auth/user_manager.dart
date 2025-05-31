import '../../../models/user.dart';
import '../../../repositories/remote/user/user_repository_impl.dart';
import '../../di/di.dart';
import '../network/network_manager.dart';
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

  Future<bool> login({
    required String userName,
    required String password,
  }) async {
    final String token = await userRepo.login(userName, password);
    await tokenManagerInstance.storeAccessToken(token);
    await tokenManagerInstance.refreshToken();
    getItInstance.get<NetworkManager>().initDefaultHeaders(token);
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
