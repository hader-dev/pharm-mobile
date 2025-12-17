import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  runApp(
    const HaderPharmApp(),
  );
}
