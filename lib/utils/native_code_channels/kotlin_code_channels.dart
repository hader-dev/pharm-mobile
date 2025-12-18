import 'package:flutter/services.dart';

class KotlinCodeChannelsHelper {
  static const kotlinChannelInstance = MethodChannel('com.hader.pharma/blueTooth');
  Future<void> scanDevices() async {
    await kotlinChannelInstance.invokeMethod('scanDevices');
  }

  Future<void> stopScanDevices() async {
    await kotlinChannelInstance.invokeMethod('stopScanDevices');
  }
}
