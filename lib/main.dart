import 'package:flutter/material.dart';

import 'config/di/di.dart';
import 'features/app/hader_pharm.dart';
import 'utils/env_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvHelper.loadAppEnvVars();
  await initAppDependencies();
  runApp(const HaderPharmApp());
}
