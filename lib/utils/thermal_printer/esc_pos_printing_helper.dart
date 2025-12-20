import 'package:flutter_thermal_printer/flutter_thermal_printer.dart'
    show CapabilityProfile, PaperSize, Generator, PosStyles, PosAlign, PosTextSize;
import 'package:flutter_thermal_printer/utils/printer.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart' show PrintBluetoothThermal;

class EscPosPrintingHelper {
  static Future<void> print(Printer printer) async {
    final bool result = await PrintBluetoothThermal.connect(macPrinterAddress: printer.address!);
    await PrintBluetoothThermal.writeBytes(await testTicket());
  }

  static Future<List<int>> testTicket() async {
    List<int> bytes = [];
    // Using default profile

    final profile = await CapabilityProfile.load();

    final generator = Generator(PaperSize.mm80, profile);

    bytes += generator.text('Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    bytes += generator.text(
      'Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
    );
    bytes += generator.text(
      'Special 2: blåbærgrød',
    );

    bytes += generator.text('Bold text', styles: PosStyles(bold: true));
    bytes += generator.text('Reverse text', styles: PosStyles(reverse: true));
    bytes += generator.text('Underlined text', styles: PosStyles(underline: true), linesAfter: 1);
    bytes += generator.text('Align left', styles: PosStyles(align: PosAlign.left));
    bytes += generator.text('Align center', styles: PosStyles(align: PosAlign.center));
    bytes += generator.text('Align right', styles: PosStyles(align: PosAlign.right), linesAfter: 1);

    bytes += generator.text('Text size 200%',
        styles: PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));

    bytes += generator.feed(2);
    bytes += generator.cut();

    return bytes;
  }
}
