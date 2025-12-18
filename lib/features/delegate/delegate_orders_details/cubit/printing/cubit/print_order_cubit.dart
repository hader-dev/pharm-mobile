import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_thermal_printer/utils/printer.dart' show Printer;
import 'package:hader_pharm_mobile/utils/classic_thermal_printing_helper.dart' show ClassicThermalPrintingHelper;
import 'package:hader_pharm_mobile/utils/thermal_printing_helper.dart';

part 'print_order_state.dart';

class PrintDelegateOrderCubit extends Cubit<PrintDelegateOrderState> {
  ThermalPrintingHelper thermalPrintingHelper;
  ClassicThermalPrintingHelper classicThermalPrintingHelper;
  List<Printer> printers = [];
  Printer? connectedPrinter;

  PrintDelegateOrderCubit({required this.thermalPrintingHelper, required this.classicThermalPrintingHelper})
      : super(PrintOrderInitial());

  void turnBLToothOn() async {
    bool isBLthoothTurnedOn = await thermalPrintingHelper.turnBLToothOn();
    if (isBLthoothTurnedOn) {
      emit(BlueToothTurnedOn());
    } else {
      emit(BlueToothTurnedOff());
    }
  }

  void startPrintersScan() {
    emit(PrintersScanStarted());
    emit(PrintersLoading());
    //thermalPrintingHelper.startPrintersScan();
    classicThermalPrintingHelper.startPrintersScan();
    // thermalPrintingHelper.printersStream.listen((List<Printer> scannedPrinters) {
    //   debugPrint("Available printers:$scannedPrinters");
    //   printers = scannedPrinters;
    //   emit(PrintersLoaded());
    // });
  }

  void stopPrintersScan() async {
    await thermalPrintingHelper.stopPrintersScan();
    emit(PrintersScanStopped());
  }

  void connectPrinter(Printer printer) async {
    // bool isConnected = await thermalPrintingHelper.connectPrinter(printer);
    // if (isConnected) {
    //   connectedPrinter = printer;
    //   emit(ConnectingPrinterSuccess());
    //   return;
    // }
    emit(ConnectingPrinterFailed());
  }
}
