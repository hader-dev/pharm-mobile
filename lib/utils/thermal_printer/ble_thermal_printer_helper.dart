import 'dart:typed_data' show Uint8List;

import 'package:flutter/material.dart' show Colors, SizedBox, Widget;

import 'package:flutter/material.dart';

import 'dart:typed_data';
import 'package:screenshot/screenshot.dart';
import 'package:image/image.dart' as img;

class BLEThermalPrintersHelper {
  static final screenshotController = ScreenshotController();
  static final TextStyle textStyle = TextStyle(fontSize: 26, color: Colors.black, fontWeight: FontWeight.w400);
  // Future<bool> turnBLToothOn() async {
  //   // try {
  //   //   await AppPermissionsHelper().requestBluetoothPermissions();
  //   //   if (!await _flutterThermalPrinterPlugin.isBleTurnedOn()) {
  //   //     await _flutterThermalPrinterPlugin.turnOnBluetooth();
  //   //     return true;
  //   //   }
  //   //   return false;
  //   // } catch (e) {
  //   //   return false;
  //   // }
  //   return true;
  // }

  // Future<void> printText(Printer printer, String text) async {
  //   await _flutterThermalPrinterPlugin.printImageBytes();
  // }

  static Future<Uint8List> generateJpegFromWidget() async {
    // Capture widget as PNG bytes
    final pngBytes = await screenshotController.captureFromWidget(
      ticketWidget(),
      pixelRatio: 2,
      // higher for better quality
    );

    // Decode PNG to Image from image package
    final image = img.decodeImage(pngBytes);
    if (image == null) {
      throw Exception("Failed to decode PNG");
    }

    // Encode as JPEG
    final jpegBytes = img.encodeJpg(image, quality: 90); // quality 0-100
    return Uint8List.fromList(jpegBytes);
  }

  static Widget ticketWidget() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Shop Header
          Center(
            child: Column(
              children: [
                Text(
                  'My Shop Name',
                  style: textStyle,
                ),
                SizedBox(height: 10),
                Text('123 Street Name, City', style: textStyle),
                SizedBox(height: 10),
                Text('Tel: +1234567890', style: textStyle),
              ],
            ),
          ),
          SizedBox(height: 10),
          Divider(thickness: 5, color: Colors.black),
          // Order info
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Order #: 12345', style: textStyle),
              SizedBox(height: 10),
              Text('Date: 2025-12-20', style: textStyle),
            ],
          ),
          SizedBox(height: 10),

          // Items list
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              receiptItem('Burger', 2, 5.0),
              receiptItem('Fries', 1, 2.5),
              receiptItem('Coke', 3, 1.5),
            ],
          ),
          SizedBox(height: 10),
          Divider(thickness: 5, color: Colors.black),
          SizedBox(height: 10),
          // Totals
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal:', style: textStyle),
              SizedBox(height: 10),
              Text('\$17.0', style: textStyle),
            ],
          ),

          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tax (10%):', style: textStyle),
              SizedBox(height: 10),
              Text('\$1.7', style: textStyle),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total:', style: textStyle),
              SizedBox(height: 10),
              Text('\$18.7', style: textStyle),
            ],
          ),
          Divider(thickness: 5, color: Colors.black),
          // Footer
          SizedBox(height: 10),
          Center(
            child: Column(
              children: [
                Text('Thank you for your order!', style: textStyle),
                SizedBox(height: 5),
                Text('Visit Again!', style: textStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget receiptItem(String name, int qty, double price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$name x$qty', style: textStyle),
          Text('\$${(qty * price).toStringAsFixed(2)}', style: textStyle),
        ],
      ),
    );
  }

  static Widget ticketWidgetArabic() {
    const textStyle = TextStyle(fontSize: 40, color: Colors.black); // adjust font size for printer

    return Directionality(
      textDirection: TextDirection.rtl, // Right-to-left for Arabic
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Shop Header
            Center(
              child: Column(
                children: [
                  Text('اسم المتجر', style: textStyle),
                  SizedBox(height: 5),
                  Text('123 شارع المدينة', style: textStyle),
                  SizedBox(height: 5),
                  Text('هاتف: +1234567890', style: textStyle),
                ],
              ),
            ),
            Divider(thickness: 5, color: Colors.black),
            // Order info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('رقم الطلب: 12345', style: textStyle),
                Text('التاريخ: 2025-12-20', style: textStyle),
              ],
            ),
            SizedBox(height: 10),
            // Items list
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                receiptItemArabic('برجر', 2, 5.0),
                receiptItemArabic('بطاطا مقلية', 1, 2.5),
                receiptItemArabic('كوكاكولا', 3, 1.5),
              ],
            ),
            Divider(thickness: 5, color: Colors.black),
            // Totals
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('المجموع الفرعي:', style: textStyle),
                Text('17.0 \$', style: textStyle),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('الضريبة (10%):', style: textStyle),
                Text('1.7 \$', style: textStyle),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('الإجمالي:', style: textStyle),
                Text('18.7 \$', style: textStyle),
              ],
            ),
            Divider(thickness: 5, color: Colors.black),
            // Footer
            Center(
              child: Column(
                children: [
                  Text('شكراً لطلبك!', style: textStyle),
                  SizedBox(height: 5),
                  Text('نأمل زيارتك مرة أخرى!', style: textStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// Helper function for Arabic items
  static Widget receiptItemArabic(String name, int qty, double price) {
    const textStyle = TextStyle(fontSize: 40, color: Colors.black);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text('$name x$qty', style: textStyle)),
          Text('${(qty * price).toStringAsFixed(2)} \$', style: textStyle),
        ],
      ),
    );
  }

  static Future<Uint8List> generateReceiptImage() async {
    final imageBytes = await screenshotController.captureFromWidget(
      ticketWidget(),
      pixelRatio: 2,
    );
    return imageBytes;
  }
}
