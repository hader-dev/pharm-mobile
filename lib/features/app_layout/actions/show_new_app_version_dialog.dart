import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/features/common/widgets/new_app_version_widget.dart';
import 'package:hader_pharm_mobile/repositories/remote/configs/config_repository.dart';
import 'package:hader_pharm_mobile/repositories/remote/configs/params/mobile_app_version.dart';
import 'package:hader_pharm_mobile/utils/shared_prefs.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> showNewAppVersionDialog({bool triggerdManually = false}) async {
  final maxDisplayCount = 4;
  final info = await PackageInfo.fromPlatform();
  final isFirstLogin =
      getItInstance.get<SharedPreferences>().getBool(SPKeys.isFirstLoggin) ??
          true;

  final appVersion = await getItInstance
      .get<IConfigRepository>()
      .getAvaillableAppUpdate(
          ParamsMobileAppVersion(myAppVersion: info.version));

  debugPrint(
      "App version: ${info.version} remote version: ${appVersion.version}");

  final updateAppDialogCountDisplayLimit = (getItInstance
          .get<SharedPreferences>()
          .getInt(SPKeys.updateAppDialogCountDisplayLimist) ??
      0);

  final isNewUpdateAvaillable = appVersion.isUpdateAvaillable &&
      (updateAppDialogCountDisplayLimit <= maxDisplayCount);
  final displayDialog =
      triggerdManually || (!isFirstLogin && isNewUpdateAvaillable);

  if (displayDialog) {
    getItInstance.get<SharedPreferences>().setInt(
        SPKeys.updateAppDialogCountDisplayLimist,
        updateAppDialogCountDisplayLimit + 1);

    showDialog(
      context: RoutingManager.rootNavigatorKey.currentContext!,
      builder: (context) => Dialog(
        clipBehavior: Clip.antiAlias,
        child: UpdateAvailableWidget(
          mobileAppVersion: appVersion,
        ),
      ),
    );
  }
}

void resetUpdateAppDialogCountDisplayLimit() {
  getItInstance
      .get<SharedPreferences>()
      .setInt(SPKeys.updateAppDialogCountDisplayLimist, 0);
}

Future<void> openAppUpdateLink(String url) async {
  resetUpdateAppDialogCountDisplayLimit();
  final uri = Uri.parse(url);
  try {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e, stackrace) {
    debugPrintStack(stackTrace: stackrace);
    debugPrint('Could not launch $url');
  }
}
