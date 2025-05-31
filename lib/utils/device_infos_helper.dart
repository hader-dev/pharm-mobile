import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  static Future<int> getSdkInt() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    int sdkInt = androidInfo.version.sdkInt;

    return sdkInt;
  }
}
