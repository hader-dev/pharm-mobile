import 'package:bluetooth_classic/bluetooth_classic.dart' show BluetoothClassic;
import 'package:bluetooth_classic/models/device.dart' show Device;
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/material.dart' show BuildContext, Widget;
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:thermal_printer/thermal_printer.dart';

import 'package:hader_pharm_mobile/utils/app_permission_helper.dart' show AppPermissionsHelper;

class ClassicThermalPrintingHelper {
  late PrinterManager _flutterThermalPrinterPlugin;
  // Stream<List<Printer>> get printersStream => _flutterThermalPrinterPlugin.devicesStream;
  // Stream<bool> get blueToothStream => _flutterThermalPrinterPlugin.isBleTurnedOnStream;

  ClassicThermalPrintingHelper() {
    _flutterThermalPrinterPlugin = PrinterManager.instance;
  }

  Future<void> startPrintersScan() async {
    await AppPermissionsHelper().requestBluetoothPermissions();
    FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      // r.device is BluetoothDevice
      print("Found Classic device: ${r.device.name} - ${r.device.address}");
    });

    Future<void> stopPrintersScan() async {
      // await _flutterThermalPrinterPlugin.stopScan();
    }

    //Future<bool> connectPrinter(Printer printer) async => await _flutterThermalPrinterPlugin.connect(printer);
  }
}
