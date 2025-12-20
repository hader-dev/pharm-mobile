import 'package:bloc/bloc.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart' show BluetoothDevice, BlueThermalPrinter;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Text;
import 'package:flutter/services.dart';
import 'package:flutter_thermal_printer/flutter_thermal_printer.dart' show Generator;
import 'package:flutter_thermal_printer/utils/printer.dart' show Printer;
import 'package:hader_pharm_mobile/utils/native_code_channels/bt_native_channels.dart'
    show BlueToothNativeChannelsHelper, BluetoothDeviceModel;

import 'package:hader_pharm_mobile/utils/thermal_printer/ble_thermal_printer_helper.dart';
import 'package:hader_pharm_mobile/utils/thermal_printer/esc_pos_printing_helper.dart' show EscPosPrintingHelper;

part 'print_order_state.dart';

class PrintDelegateOrderCubit extends Cubit<PrintDelegateOrderState> {
  final BLEThermalPrintersHelper thermalPrintingHelper;

  List<Printer> blePrinters = [];
  List<BluetoothDeviceModel> pairedDevices = [];
  //PrinterDevice? pairedPrinter;
  Printer? connectedPrinter;

  PrintDelegateOrderCubit({
    required this.thermalPrintingHelper,
  }) : super(PrintOrderInitial());

  Future<void> init() async {
    await turnBLToothOn();
    getPairedPrinters();
  }

  Future<void> turnBLToothOn() async {
    bool isBLthoothTurnedOn = await thermalPrintingHelper.turnBLToothOn();
    if (isBLthoothTurnedOn) {
      emit(BlueToothTurnedOn());
    } else {
      emit(BlueToothTurnedOff());
    }
  }

  void startPrintersScan() async {
    emit(PrintersScanStarted());
    emit(PrintersLoading());
    pairedDevices = await BlueToothNativeChannelsHelper().getBoundedDevices();
    // thermalPrintingHelper.printersStream.listen((List<Printer> scannedPrinters) {
    //   debugPrint("Available printers:$scannedPrinters");
    //   blePrinters = scannedPrinters;
    //   emit(PrintersLoaded());
    // });
  }

  Future<void> getPairedPrinters() async {
    emit(PairedPrintersLoading());
    pairedDevices = await BlueToothNativeChannelsHelper().getBoundedDevices();

    // pairedDevices = await thermalPrintingHelper.startPrintersScan();
    // thermalPrintingHelper.flutterThermalPrinterPlugin.onStateChanged().listen((state) {
    //   switch (state) {
    //     case BlueThermalPrinter.CONNECTED:
    //       debugPrint("State changed CONNECTED ");

    //       break;
    //     case BlueThermalPrinter.DISCONNECTED:
    //       debugPrint("State changed DISCONNECTED ");
    //       break;
    //     case BlueThermalPrinter.DISCONNECT_REQUESTED:
    //       debugPrint("State changed DISCONNECT_REQUESTED ");
    //       break;
    //     case BlueThermalPrinter.STATE_TURNING_OFF:
    //       debugPrint("State changed STATE_TURNING_OFF ");
    //       break;
    //     case BlueThermalPrinter.STATE_OFF:
    //       debugPrint("State changed STATE_OFF ");
    //       break;
    //     case BlueThermalPrinter.STATE_ON:
    //       debugPrint("State changed STATE_ON ");
    //       break;
    //     case BlueThermalPrinter.STATE_TURNING_ON:
    //       debugPrint("State changed STATE_TURNING_ON ");
    //       break;
    //     case BlueThermalPrinter.ERROR:
    //       debugPrint("State changed ERROR ");
    //       break;
    //     default:
    //       break;
    //   }
    // });
    emit(PairedPrintersLoaded());
  }

  void stopPrintersScan() async {
    // await thermalPrintingHelper.stopPrintersScan();
    emit(PrintersScanStopped());
  }

  void connectPrinter(Printer printer) async {
    await BlueToothNativeChannelsHelper().sendToPrinter(printer.address!, "hello wolrd".codeUnits);
    //await thermalPrintingHelper.printTicket(printer);
  }

  Future<void> printOrderReceipt(Printer printer) async {
    EscPosPrintingHelper.print(printer);
  }
}
