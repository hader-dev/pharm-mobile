import 'package:permission_handler/permission_handler.dart';

import '../config/di/di.dart';
import '../features/common/dialog/validation_dialog.dart';

class AppPermissionsHelper {
  static var dialog = getItInstance.get<ValidateActionDialog>();

  Future<void> requestBluetoothPermissions() async {
    await [Permission.bluetooth, Permission.bluetoothScan, Permission.bluetoothConnect, Permission.location].request();
  }
  // static Future<PermissionStatus> checkPhotosPermission() async {
  //   PermissionStatus isPermissionGranted = await DeviceInfo.getSdkInt() <= 32
  //       ? await Permission.storage
  //           .onDeniedCallback(() => dialog.showValidateActionDialog(
  //               dialogType: DialogType.error,
  //               title: Text(
  //                 "localization.permissionDenied",
  //                 textAlign: TextAlign.center,
  //               ),
  //               content: Text(
  //                 "localization.allowAccessToPhotos",
  //                 textAlign: TextAlign.center,
  //                 // style: context.theme.textTheme.bodySmall!.copyWith(),
  //               ),
  //               onValidate: () async => await Permission.storage.request(),
  //               onCancel: () {}))
  //           .request()
  //       : await Permission.photos
  //           .onDeniedCallback(() => dialog.showValidateActionDialog(
  //               dialogType: DialogType.error,
  //               title: Text(
  //                 'localization.permissionDenied',
  //                 textAlign: TextAlign.center,
  //               ),
  //               content: Text(
  //                 "localization.allowAccessToPhotos",
  //                 textAlign: TextAlign.center,
  //                 //style: context.theme.textTheme.bodySmall!.copyWith(),
  //               ),
  //               onValidate: () async => await Permission.photos.request(),
  //               onCancel: () {}))
  //           .request();
  //   return isPermissionGranted;
  // }

  // static Future<void> appPermission() async {
  //   bool permissionsGranted = false;
  //   int attempts = 1;
  //   late Map<Permission, PermissionStatus> statuses;
  //   late int sdkInt;
  //   while (!permissionsGranted) {
  //     if (Platform.isAndroid) {
  //       sdkInt = await DeviceInfo.getSdkInt();
  //       if (sdkInt > 29) {
  //         statuses =
  //             await <Permission>[Permission.manageExternalStorage].request();
  //       } else {
  //         statuses = await <Permission>[Permission.storage].request();
  //       }
  //     }

  //     attempts += 1;

  //     if (attempts > 3) {
  //       break;
  //     }

  //     if (Platform.isAndroid) {
  //       if (sdkInt > 29) {
  //         if ((statuses[Permission.manageExternalStorage] ==
  //             PermissionStatus.granted)) {
  //           permissionsGranted = true;
  //           break;
  //         }
  //       } else {
  //         if ((statuses[Permission.storage] == PermissionStatus.granted)) {
  //           permissionsGranted = true;
  //           break;
  //         }
  //       }
  //     }
  //   }
  // }
}
