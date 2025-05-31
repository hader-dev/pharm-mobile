import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

import 'device_infos_helper.dart';

class AppPermissionsHelper {
  static Future<void> appPermission() async {
    bool permissionsGranted = false;
    int attempts = 1;
    late Map<Permission, PermissionStatus> statuses;
    late int sdkInt;
    while (!permissionsGranted) {
      if (Platform.isAndroid) {
        sdkInt = await DeviceInfo.getSdkInt();
        if (sdkInt > 29) {
          statuses = await <Permission>[Permission.manageExternalStorage].request();
        } else {
          statuses = await <Permission>[Permission.storage].request();
        }
      }

      attempts += 1;

      if (attempts > 3) {
        break;
      }

      if (Platform.isAndroid) {
        if (sdkInt > 29) {
          if ((statuses[Permission.manageExternalStorage] ==
              PermissionStatus.granted)) {
            permissionsGranted = true;
            break;
          }
        } else {
          if ((statuses[Permission.storage] == PermissionStatus.granted)) {
            permissionsGranted = true;
            break;
          }
        }
      }
    }
  }
}
