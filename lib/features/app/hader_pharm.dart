import 'package:flutter/material.dart';

import '../../config/routes/routing_manager.dart';
import '../../config/theme/light_theme.dart';

class HaderPharmApp extends StatelessWidget {
  // This widget is the root of your application.
  const HaderPharmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Hader Pharm',
      theme: LightTheme.theme,
      routerConfig: RoutingManager.router,
    );
  }
}
