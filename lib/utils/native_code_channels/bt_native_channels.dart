import 'package:blue_thermal_printer/blue_thermal_printer.dart' show BluetoothDevice;
import 'package:flutter/services.dart';

import 'package:flutter_thermal_printer/utils/printer.dart' show ConnectionType, Printer;
import 'package:hader_pharm_mobile/utils/app_permission_helper.dart' show AppPermissionsHelper;
import 'package:hader_pharm_mobile/utils/thermal_printer/bt_devices_classifier.dart'
    show BtDevicesClassifier, DeviceType;
import 'package:hader_pharm_mobile/utils/thermal_printer/esc_pos_printing_helper.dart' show EscPosPrintingHelper;

class BlueToothNativeChannelsHelper {
  static const kotlinChannelInstance = MethodChannel('com.hader.pharma/blueTooth');
  Future<void> scanDevices() async {
    await kotlinChannelInstance.invokeMethod('scanDevices');
  }

  Future<List<BluetoothDeviceModel>> getDevices() async {
    List<Object?> rawDevicesData = await kotlinChannelInstance.invokeMethod('getDevices');
    rawDevicesData = rawDevicesData.where((element) => element != null).toList();
    return rawDevicesData.map((e) => BluetoothDeviceModel.fromMap(e as Map<Object?, Object?>)).toList();
  }

  Future<List<BluetoothDeviceModel>> getBoundedDevices() async {
    List<Object?> rawDevicesData = await kotlinChannelInstance.invokeMethod('getBoundedDevices');
    rawDevicesData = rawDevicesData.where((element) => element != null).toList();
    return rawDevicesData.map((e) => BluetoothDeviceModel.fromMap(e as Map<Object?, Object?>)).toList();
  }

  Future<bool> sendToPrinter(
    String address,
    List<int> bytes,
  ) async {
    await AppPermissionsHelper().requestBluetoothPermissions();
    final result = await kotlinChannelInstance.invokeMethod<bool>(
      'sendBitMapData',
      {
        'address': address,
        'data': bytes,
      },
    );
    return result ?? false;
  }

  // Future<bool> sendImageToPrinter(
  //   String address,
  //   Uint8List bytes,
  // ) async {
  //   try {
  //     await AppPermissionsHelper().requestBluetoothPermissions();

  //     final result = await kotlinChannelInstance.invokeMethod<bool>(
  //       'sendData',
  //       {
  //         'address': address,
  //         'data': bytes,
  //       },
  //     );
  //     return result ?? false;
  //   } catch (e) {
  //     print(e.toString());
  //     return false;
  //   }
  // }

  Future<void> stopScanDevices() async {
    await kotlinChannelInstance.invokeMethod('stopScan');
  }
}

class BluetoothDeviceModel {
  final String sppUuid = "00001101-0000-1000-8000-00805f9b34fb";
  final String? name;
  final String address;
  final String bondState;
  final String type;
  final List<String>? uuids;
  final int? bluetoothClass;
  final int? majorDeviceClass;
  final bool isConnected;

  BluetoothDeviceModel({
    required this.name,
    required this.address,
    required this.bondState,
    required this.type,
    required this.uuids,
    required this.bluetoothClass,
    required this.majorDeviceClass,
    required this.isConnected,
  });

  factory BluetoothDeviceModel.fromMap(Map<Object?, Object?> map) {
    return BluetoothDeviceModel(
      name: map['name'] as String?,
      address: map['address'] as String,
      bondState: map['bondState'] as String,
      type: map['type'] as String,
      uuids: map['uuids'] != null ? List<String>.from(map['uuids'] as List) : null,
      bluetoothClass: map['bluetoothClass'] as int?,
      majorDeviceClass: map['majorDeviceClass'] as int?,
      isConnected: map['isConnected'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'bondState': bondState,
      'type': type,
      'uuids': uuids,
      'bluetoothClass': bluetoothClass,
      'majorDeviceClass': majorDeviceClass,
      'isConnected': isConnected,
    };
  }

  BluetoothDevice toPrinterModel() {
    return BluetoothDevice(name, address);
  }

  bool get isPrinter => BtDevicesClassifier.classifyByUuids(uuids) == DeviceType.printer;
}
