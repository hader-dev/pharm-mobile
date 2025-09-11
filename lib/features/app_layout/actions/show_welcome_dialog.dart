import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/features/common/widgets/welcoming_widget.dart';
import 'package:hader_pharm_mobile/utils/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> showWelcomingDialog() async {
  final isFirstLogin =
      getItInstance.get<SharedPreferences>().getBool(SPKeys.isFirstLoggin) ??
          true;

  if (isFirstLogin) {
    Future.delayed(Duration(milliseconds: 400), () {
      showDialog(
          context: RoutingManager.rootNavigatorKey.currentContext!,
          builder: (context) =>
              Dialog(clipBehavior: Clip.antiAlias, child: WelcomingWidget()));
    });
    getItInstance.get<SharedPreferences>().setBool(SPKeys.isFirstLoggin, false);
  }
}
