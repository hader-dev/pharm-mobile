import 'dart:typed_data' show Uint8List;

import 'package:blue_thermal_printer/blue_thermal_printer.dart' show BlueThermalPrinter, BluetoothDevice;
import 'package:flutter/material.dart' show BuildContext, Widget;
import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:flutter_thermal_printer/utils/printer.dart' show Printer;
import 'package:flutter/material.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:hader_pharm_mobile/utils/app_permission_helper.dart' show AppPermissionsHelper;

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;

class BLEThermalPrintersHelper {
  late final BlueThermalPrinter flutterThermalPrinterPlugin;

  BLEThermalPrintersHelper() {
    flutterThermalPrinterPlugin = BlueThermalPrinter.instance;
  }

  Future<bool> turnBLToothOn() async {
    // try {
    //   await AppPermissionsHelper().requestBluetoothPermissions();
    //   if (!await _flutterThermalPrinterPlugin.isBleTurnedOn()) {
    //     await _flutterThermalPrinterPlugin.turnOnBluetooth();
    //     return true;
    //   }
    //   return false;
    // } catch (e) {
    //   return false;
    // }
    return true;
  }

  // Future<void> printText(Printer printer, String text) async {
  //   await _flutterThermalPrinterPlugin.printImageBytes();
  // }

  Future<void> printTicket(Printer printer) async {
    final screenshotController = ScreenshotController();

// Example widget to print
    Widget ticketWidget() {
      return Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('مرحبا بالعالم', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('Special: àÀ éÉ üÜ çÇ', style: TextStyle(fontSize: 18)),
            Text('English: ABC abc 123', style: TextStyle(fontSize: 18)),
          ],
        ),
      );
    }

    Future<Uint8List> captureTicket() async {
      final imageBytes = await screenshotController.captureFromWidget(
        ticketWidget(),
        pixelRatio: 2, // increase for better quality
      );
      return imageBytes;
    }

    // 1. Connect to printer
    final connected = await PrintBluetoothThermal.connect(macPrinterAddress: printer.address!);
    if (!connected) return;

    // 2. Capture widget as image
    final imageBytes = await captureTicket();

    // 3. Load ESC/POS profile
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);

    // 4. Convert image to ESC/POS bytes
    final List<int> bytes = [];
    final img.Image image = img.decodeImage(imageBytes)!;
    bytes.addAll(generator.image(image));
    bytes.addAll(generator.cut());

    // 5. Send bytes to printer
    await PrintBluetoothThermal.writeBytes(bytes);

    // 6. Disconnect
    await PrintBluetoothThermal.disconnect;
  }

  Future<List<BluetoothDevice>> startPrintersScan() async {
    await AppPermissionsHelper().requestBluetoothPermissions();
    return await flutterThermalPrinterPlugin.getBondedDevices();
  }

  // Future<void> stopPrintersScan() async {
  //   await _flutterThermalPrinterPlugin.stopScan();
  // }

  Future<bool> connectPrinter(BluetoothDevice printer) async => await flutterThermalPrinterPlugin.connect(printer);
}

enum PrintSize {
  medium, //normal size text
  bold, //only bold text
  boldMedium, //bold with medium
  boldLarge, //bold with large
  extraLarge //extra large
}

enum PrintAlign {
  left, //ESC_ALIGN_LEFT
  center, //ESC_ALIGN_CENTER
  right, //ESC_ALIGN_RIGHT
}
