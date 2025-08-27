import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

class TokenManager {
  static final tokenHeaderKey = "Authorization";
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

  Future<void> refreshToken(INetworkService client) async {
    var decodedResponse =
        await client.sendRequest(() => client.post(Urls.refreshToken));
    var newToken = decodedResponse[accessTokenStoreKey];
    token = newToken;
    client.refreshAuthHeader(newToken);

    await storeAccessToken(newToken);
  }

  void optimisticUpdate(String token) {
    this.token = token;
  }

  Future<String?> getAccessToken() async =>
      await secureStorage.read(key: accessTokenStoreKey);

  Future<void> removeToken() async {
    token = null;
    await secureStorage.deleteAll();
  }
}
