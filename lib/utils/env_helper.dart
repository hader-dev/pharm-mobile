import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvHelper {
  static const String schemaEnvKey = 'REQUEST_SCHEMA';
  static const String baseUrlEnvKey = 'API_BASE_URL';
  static const String apiVersionEnvKey = 'API_VERSION';
  static const String fileUrl = 'FILE_URL';
  static const String appVersion = 'APP_VERSION';
  static const String featureFlagUpdatePopup = 'FEATURE_FLAG_UPDATE_POPUP';
  static const String sentryDsnKey = 'SENTRY_DSN';
  static const String envModeKey = 'MODE';

  static Future<void> loadAppEnvVars() async {
    await dotenv.load();
  }

  static String getStoredEnvValue<T>(String key) {
    return dotenv.get(key);
  }

  static bool getFeatureFlag(String key) {
    return dotenv.getBool(key);
  }
}
