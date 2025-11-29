import 'package:in_app_update/in_app_update.dart';

class AppUpdater {
  static Future<void> checkForUpdates() async {
    AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();

    if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
      if (updateInfo.immediateUpdateAllowed) {
        InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
          if (appUpdateResult == AppUpdateResult.success) {}
        });
      } else if (updateInfo.flexibleUpdateAllowed) {
        InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
          if (appUpdateResult == AppUpdateResult.success) {
            InAppUpdate.completeFlexibleUpdate();
          }
        });
      }
    }
  }
}
