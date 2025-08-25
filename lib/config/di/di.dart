import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hader_pharm_mobile/config/services/deeplinks/deeplinks_service.dart';
import 'package:hader_pharm_mobile/config/services/deeplinks/deeplinks_service_port.dart';
import 'package:hader_pharm_mobile/config/services/notification/notification_service.dart';
import 'package:hader_pharm_mobile/config/services/notification/notification_service_port.dart';
import 'package:hader_pharm_mobile/repositories/remote/filters/filters_repository.dart';
import 'package:hader_pharm_mobile/repositories/remote/filters/filters_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/notification_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/common/dialog/validation_dialog.dart';
import '../../repositories/remote/user/user_repository_impl.dart';
import '../../utils/env_helper.dart';
import '../../utils/shared_prefs.dart';
import '../services/auth/token_manager.dart';
import '../services/auth/user_manager.dart';
import '../services/firebase/firebase_service.dart';
import '../services/network/dio/dio_network_manager.dart';
import '../services/network/network_interface.dart';

GetIt getItInstance = GetIt.instance;

initAppDependencies() async {
  final SharedPreferences storage = await Prefs.init();

  const FlutterSecureStorage securedStorage = FlutterSecureStorage();

  getItInstance.registerLazySingleton<ToastManager>(() => ToastManager());
  final ValidateActionDialog dialogManager = ValidateActionDialog();
  //final HiveDbManager hiveStorage = HiveDbManager.getInstance;
  getItInstance.registerLazySingleton<SharedPreferences>(() => storage);
  getItInstance
      .registerLazySingleton<FlutterSecureStorage>(() => securedStorage);
  //getItInstance.registerLazySingleton<HiveDbManager>(() => hiveStorage);
  getItInstance
      .registerLazySingleton<ValidateActionDialog>(() => dialogManager);
  final TokenManager tokenManager = TokenManager.instance;
  tokenManager.init(getItInstance());
  getItInstance.registerLazySingleton<TokenManager>(() => tokenManager);

  final DioNetworkManager dioNetworkManager = DioNetworkManager.instance;
  await dioNetworkManager.init(
      '''${EnvHelper.getStoredEnvValue(EnvHelper.schemaEnvKey)}://${EnvHelper.getStoredEnvValue(EnvHelper.baseUrlEnvKey)}
      /${EnvHelper.getStoredEnvValue(EnvHelper.apiVersionEnvKey)}''',
      Dio(),
      tokenManager);

  getItInstance.registerLazySingleton<INetworkService>(() => dioNetworkManager);
  getItInstance.registerLazySingleton<UserManager>(() => UserManager.init(
      userRepository: UserRepository(client: getItInstance()),
      tokenManager: getItInstance()));

  final firebaseService = FirebaseService();
  await firebaseService.init();
  final notificationService = NotificationService(
      firebaseService: firebaseService,
      notificationRepository: NotificationRepository(
        client: getItInstance(),
      ));
  await notificationService.init();

  getItInstance
      .registerLazySingleton<INotificationService>(() => notificationService);

  // Initialize DeeplinksService
  final deeplinksService = DeeplinksService();
  await deeplinksService.init();
  getItInstance
      .registerLazySingleton<DeeplinksServicePort>(() => deeplinksService);

  final filtersRepository = FiltersRepositoryImpl(client: dioNetworkManager);
  getItInstance
      .registerLazySingleton<IFiltersRepository>(() => filtersRepository);
}
