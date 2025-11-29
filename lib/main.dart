import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentry_flutter/sentry_flutter.dart' show SentryFlutter;

import 'config/di/di.dart';
import 'features/app/hader_pharm.dart';
import 'utils/env_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvHelper.loadAppEnvVars();
  await initAppDependencies();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await SentryFlutter.init((options) {
    options.dsn = EnvHelper.getStoredEnvValue(EnvHelper.sentryDsnKey);
    options.tracesSampleRate = 1.0;
    options.profilesSampleRate = 1.0;
    options.attachScreenshot = false;

    options.environment = EnvHelper.getStoredEnvValue(EnvHelper.envModeKey);
  },
      appRunner: () => runApp(
            const HaderPharmApp(),
          ));
}
