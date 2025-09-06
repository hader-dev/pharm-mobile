import 'package:flutter/cupertino.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/models/invoice.dart';
import 'package:hader_pharm_mobile/models/order.dart';
import 'package:hader_pharm_mobile/models/user.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/mappers/json_to_invoice_model.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/invoice.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/invoice_response.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<ResponseInvoice> getInvoiceDetaills(
    ParamsGetInvoice params, INetworkService client) async {
  var decodedResponse = await client
      .sendRequest(() => client.get("${Urls.invoice}/${params.orderId}"));

  debugPrint("invoice details: $decodedResponse");
  final invoice = jsonToInvoiceModel(decodedResponse);
  return ResponseInvoice(invoice: invoice);
}

Future<ResponseInvoice> getMockInvoiceDetaills(
    ParamsGetInvoice params, INetworkService client) async {
  return ResponseInvoice(
    invoice: Invoice(
      orderId: "ggfgdgsdgsdg",
      invoiceNumber: "dgdgsdgsdgsdg",
      invoiceYear: 2024,
      issuedByUserId: "sqsfqsfqsfqsfqsf",
      issueDate: DateTime.now(),
      paymentStatus: 1,
      invoiceType: InvoiceTypes.facture,
      stampDutyAmount: 255,
      totalVatAmount: 2444,
      sellerCompany: Company.mock(),
      clientCompany: Company.mock(),
      order: BaseOrderModel.mock(),
      issuedByUser: UserModel.mock(),
      invoiceItems: List.filled(10, InvoiceItem.mock()),
      id: 'sgsgsgsg',
      invoiceSummary: InvoiceSummary.mock(),
    ),
  );
}
