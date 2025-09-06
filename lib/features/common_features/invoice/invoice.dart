import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common_features/invoice/actions/load_network_image.dart';
import 'package:hader_pharm_mobile/features/common_features/invoice/pages/invoice.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/invoice.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class InvoiceGenerator extends StatelessWidget {
  final String invoiceId;

  const InvoiceGenerator({super.key, required this.invoiceId});

  Future<pw.Document> _buildPdf(IOrderRepository orderRepository) async {
    final invoice = (await orderRepository
            .invoiceDetails(ParamsGetInvoice(orderId: invoiceId)))
        .invoice;

    final logoImage = await loadNetworkLogo(
     invoice.sellerCompany?.image?.path ?? "",
    );

    final pdf = pw.Document();

    final padding = AppSizesManager.s16;

    final invoiceDoc = PharmaceuticalInvoice.build(invoice, logoImage, padding);
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
    final IOrderRepository orderRepository =
        OrderRepository(client: getItInstance.get<INetworkService>());

    return Scaffold(
      appBar: AppBar(title: const Text("Invoice Generator")),
      body: PdfPreview(
        initialPageFormat: PdfPageFormat.a4,
        build: (format) async {
          final pdf = await _buildPdf(orderRepository);
          return pdf.save();
        },
      ),
    );
  }
}
