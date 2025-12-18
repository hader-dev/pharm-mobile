import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/material.dart' show BuildContext, Widget;
// import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:thermal_printer/thermal_printer.dart';

import 'package:hader_pharm_mobile/utils/app_permission_helper.dart' show AppPermissionsHelper;

class ThermalPrintingHelper {
  late PrinterManager _flutterThermalPrinterPlugin;
  // Stream<List<Printer>> get printersStream => _flutterThermalPrinterPlugin.devicesStream;
  // Stream<bool> get blueToothStream => _flutterThermalPrinterPlugin.isBleTurnedOnStream;

  ThermalPrintingHelper() {
    _flutterThermalPrinterPlugin = PrinterManager.instance;
  }

  Future<bool> turnBLToothOn() async {
    try {
      await AppPermissionsHelper().requestBluetoothPermissions();
      // if (!await _flutterThermalPrinterPlugin.isBleTurnedOn()) {
      //   await _flutterThermalPrinterPlugin.turnOnBluetooth();
      //   return true;
      // }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Future<void> printText(Printer printer, String text) async {
  //   //TODO: change empty list to list of data
  //   await _flutterThermalPrinterPlugin.printData(printer, []);
  // }

  // Future<void> printWidget(BuildContext context, Widget widget, Printer printer) async {
  //   await _flutterThermalPrinterPlugin.printWidget(context, widget: widget, printer: printer);
  // }

  Future<void> startPrintersScan() async {
    await AppPermissionsHelper().requestBluetoothPermissions();

    PrinterManager.instance
        .discovery(
      type: PrinterType.bluetooth,
    )
        .listen((printer) {
      debugPrint("Available printers:${printer.name}");
    });
  }

  Future<void> stopPrintersScan() async {
    // await _flutterThermalPrinterPlugin.stopScan();
  }

  //Future<bool> connectPrinter(Printer printer) async => await _flutterThermalPrinterPlugin.connect(printer);
}
