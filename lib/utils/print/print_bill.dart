// import 'package:blue_thermal_printer/blue_thermal_printer.dart';
// import 'package:hader_pharm_mobile/utils/print/interface/interface_print.dart' show InterfacePrint;

// class PrintBill implements InterfacePrint {
//   BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

//   PrintBill();

//   @override
//   Future<void> printTicket(BluetoothDevice device) async {
//     bluetooth.isConnected.then((isConnected) {
//       if (isConnected == true) {
//         bluetooth.printCustom('Bill', PrintSize.extraLarge.index, PrintAlign.center.index);
//       }else{
//         bluetooth.connect(device);
//       }
//     });
//     //   //     bluetooth.printCustom(companyDetails.Name ?? 'Enterprise', PrintSize.extraLarge.index, PrintAlign.center.index);
//     //   //     bluetooth.printNewLine();
//     //   //     bluetooth.printCustom(
//     //   //       companyDetails.Description == null
//     //   //           ? 'Description'
//     //   //           : companyDetails.Description!.replaceAll(RegExp(r'[^\w\s]+'), ''),
//     //   //       PrintSize.medium.index,
//     //   //       PrintAlign.center.index,
//     //   //     );
//     //   //     if (companyDetails.Phone?.toLowerCase() != null) {
//     //   //       bluetooth.printCustom(
//     //   //         'Telephone : ${companyDetails.Phone}',
//     //   //         PrintSize.medium.index,
//     //   //         PrintAlign.center.index,
//     //   //       );
//     //   //     }
//     //   //     if (companyDetails.Fax?.toLowerCase() != null) {
//     //   //       bluetooth.printCustom(
//     //   //         'Fax : ${companyDetails.Fax}',
//     //   //         PrintSize.medium.index,
//     //   //         PrintAlign.center.index,
//     //   //       );
//     //   //     }
//     //   //     bluetooth.printCustom(
//     //   //       '--------------------------------------------------------------',
//     //   //       PrintSize.medium.index,
//     //   //       PrintAlign.center.index,
//     //   //     );

//     //   //     ///client part
//     //   //     String user = Prefs.getString(SPKeys.username).toString();

//     //   //     bluetooth.printLeftRight(
//     //   //       'Date : ${DateFormat.yMd('fr').add_Hm().format(order.DateModification!)}',
//     //   //       (order.Type == OrderType.Return.index ? 'BR Code : ' : 'BL Code : ') + order.Id.toString(),
//     //   //       PrintSize.bold.index,
//     //   //     );
//     //   //     bluetooth.printNewLine();
//     //   //     bluetooth.printCustom(
//     //   //       'Client : ${clientModelData.Name}',
//     //   //       PrintSize.bold.index,
//     //   //       PrintAlign.left.index,
//     //   //     );

//     //   //     bluetooth.printNewLine();
//     //   //     bluetooth.printCustom(
//     //   //       'Cree par : $user',
//     //   //       PrintSize.bold.index,
//     //   //       PrintAlign.left.index,
//     //   //     );
//     //   //     bluetooth.printNewLine();
//     //   //     bluetooth.printCustom(
//     //   //       '--------------------------------------------------------------',
//     //   //       PrintSize.medium.index,
//     //   //       PrintAlign.center.index,
//     //   //     );
//     //   //     bluetooth.print3Column('Designation', 'Qte', 'PrixU', PrintSize.bold.index);

//     //   //     bluetooth.printCustom(
//     //   //       '--------------------------------------------------------------',
//     //   //       PrintSize.medium.index,
//     //   //       PrintAlign.center.index,
//     //   //     );
//     //   //     for (int i = 0; i < orderItems.length; i++) {
//     //   //       bluetooth.printCustom(
//     //   //         ('${i + 1}) ${orderItems[i].orderItem!.Label!}').replaceAll(RegExp(r'[^\w\s]+'), ''),
//     //   //         PrintSize.medium.index,
//     //   //         PrintAlign.center.index,
//     //   //       );

//     //   //       bluetooth.print3Column(
//     //   //         '',
//     //   //         orderItems[i].orderItem!.Qty.toString(),
//     //   //         orderItems[i].orderItem!.UPriceTTC.toString(),
//     //   //         PrintSize.medium.index,
//     //   //       );
//     //   //     }
//     //   //     bluetooth.printCustom(
//     //   //       '--------------------------------------------------------------',
//     //   //       PrintSize.medium.index,
//     //   //       PrintAlign.center.index,
//     //   //     );
//     //   //     bluetooth.printCustom(
//     //   //       'Remise : ${order.DiscountPercentage} % => ${priceRoundAndFormatForPrinting(order.Discount!)}',
//     //   //       PrintSize.bold.index,
//     //   //       PrintAlign.center.index,
//     //   //     );

//     //   //     bluetooth.printNewLine();
//     //   //     bluetooth.printCustom(
//     //   //       'Net a payer : ${priceRoundAndFormatForPrinting(order.NetToPay!)}',
//     //   //       PrintSize.bold.index,
//     //   //       PrintAlign.center.index,
//     //   //     );

//     //   //     bluetooth.printNewLine();
//     //   //     bluetooth.printNewLine();
//     //   //     bluetooth.printNewLine();
//     //   //   }
//     //   // });
//     // }
//   }
// }
