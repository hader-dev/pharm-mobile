import 'package:flutter/material.dart';

import '../../config/routes/routing_manager.dart';
import '../../config/theme/light_theme.dart';

class HaderPharmApp extends StatelessWidget {
  const HaderPharmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Hader Pharm',
      theme: LightTheme.theme,
      routerConfig: RoutingManager.router,
      builder: (context, child) => Overlay(
        initialEntries: [OverlayEntry(builder: (_) => child!)],
      ),
    );
  }
}
