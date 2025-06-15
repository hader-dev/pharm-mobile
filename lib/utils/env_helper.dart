import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvHelper {
  static const String schemaEnvKey = 'REQUEST_SCHEMA';
  static const String baseUrlEnvKey = 'API_BASE_URL';
  static const String apiVersionEnvKey = 'API_VERSION';
  static const String fileUrl = 'FILE_URL';

  static Future<void> loadAppEnvVars() async {
    await dotenv.load(fileName: kDebugMode ? ".env" : ".env.production");
  }

  static String getStoredEnvValue(String key) {
    return dotenv.get(key);
  }
}
