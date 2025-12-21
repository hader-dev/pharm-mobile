import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
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
    getPairedPrinters();
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

    emit(PairedPrintersLoaded());
  }

  void stopPrintersScan() async {
    // await thermalPrintingHelper.stopPrintersScan();
    emit(PrintersScanStopped());
  }

  void connectPrinter(Printer printer) async {
    try {
      final Uint8List imgData = await BLEThermalPrintersHelper.generateJpegFromWidget();
      BlueToothNativeChannelsHelper().sendToPrinter(printer.address!, imgData);
    } catch (e) {
      debugPrint(e.toString());
    }
    //await thermalPrintingHelper.printTicket(printer);
  }

  Future<void> printOrderReceipt(Printer printer) async {
    EscPosPrintingHelper.print(printer);
  }
}
