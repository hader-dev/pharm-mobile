import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common_features/invoice/actions/load_network_image.dart';
import 'package:hader_pharm_mobile/features/common_features/invoice/pages/invoice.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class InvoiceGenerator extends StatelessWidget {
  final Map<String, dynamic> invoiceData;

  const InvoiceGenerator({super.key, required this.invoiceData});

  Future<pw.Document> _buildPdf() async {
    final logoImage = await loadNetworkLogo(
      invoiceData['company']['logo'],
    );

    final pdf = pw.Document();

    final padding = AppSizesManager.s16;

    final invoiceDoc =
        PharmaceuticalInvoice.build(invoiceData, logoImage, padding);
    for (var page in invoiceDoc) {
      pdf.addPage(page);
    }

    // final dechargeDoc = // for now we wont provide this
    //     PharmaceuticalDecharge.build(invoiceData, logoImage, padding);
    // for (var page in dechargeDoc) {
    //   pdf.addPage(page);
    // }

    return pdf;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Invoice Generator")),
      body: PdfPreview(
        initialPageFormat: PdfPageFormat.a4,
        build: (format) async {
          final pdf = await _buildPdf();
          return pdf.save();
        },
      ),
    );
  }
}
