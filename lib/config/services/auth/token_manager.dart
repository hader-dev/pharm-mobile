import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  String? token;
  static final TokenManager _instance = TokenManager._();
  static TokenManager get instance => _instance;

  static const String accessTokenStoreKey = 'accessToken';

  //static bool isRefreshingTokens = false;

  static late FlutterSecureStorage secureStorage;

  TokenManager._();

  void init(FlutterSecureStorage storage) async {
    secureStorage = storage;
    token = await getAccessToken();
  }

  Future<void> storeAccessToken(String accessToken) async {
    await secureStorage.write(key: accessTokenStoreKey, value: accessToken);
  }

  Future<void> refreshToken() async {
    token = await getAccessToken();
  }

  Future<String?> getAccessToken() async => await secureStorage.read(key: accessTokenStoreKey);

  Future<void> removeToken() async => await secureStorage.deleteAll();
}
