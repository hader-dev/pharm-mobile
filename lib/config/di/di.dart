import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth/token_manager.dart';
import '../services/auth/user_manager.dart';
import '../services/location/user_location.dart';
import '../services/network/network_manager.dart';

GetIt getItInstance = GetIt.instance;

initAppDependencies() async {
  // final SharedPreferences storage = await Prefs.init();
  // const FlutterSecureStorage securedStorage = FlutterSecureStorage();
  // final ValidateActionDialog dialogManager = ValidateActionDialog();
  // //final HiveDbManager hiveStorage = HiveDbManager.getInstance;
  // getItInstance.registerLazySingleton<SharedPreferences>(() => storage);
  // getItInstance.registerLazySingleton<FlutterSecureStorage>(() => securedStorage);
  // //getItInstance.registerLazySingleton<HiveDbManager>(() => hiveStorage);
  // getItInstance.registerLazySingleton<ValidateActionDialog>(() => dialogManager);
  // final TokenManager tokenManager = TokenManager.instance;
  // tokenManager.init(getItInstance());
  // getItInstance.registerLazySingleton<TokenManager>(() => tokenManager);

  // final NetworkManager networkManager = NetworkManager.instance;
  // networkManager.init(
  //     '''${EnvHelper.getStoredEnvValue(EnvHelper.schemaEnvKey)}://${EnvHelper.getStoredEnvValue(EnvHelper.baseUrlEnvKey)}
  //     /${EnvHelper.getStoredEnvValue(EnvHelper.apiVersionEnvKey)}''', http.Client(), tokenManager);

  // getItInstance.registerLazySingleton<NetworkManager>(() => networkManager);
  // getItInstance.registerLazySingleton<UserManager>(() => UserManager.init(
  //     userRepository: UserRepository(client: getItInstance.get<NetworkManager>()), tokenManager: getItInstance()));
  // getItInstance.registerLazySingleton<LocationManager>(() => LocationManager.instance);
}
