import 'package:flutter/cupertino.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/mappers/json_to_invoice_model.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/params/invoice.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/response/invoice_response.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<ResponseInvoice> getInvoiceDetails(
    ParamsGetInvoice params, INetworkService client) async {
  var decodedResponse = await client
      .sendRequest(() => client.get("${Urls.invoice}/${params.orderId}"));

  debugPrint("invoice details: $decodedResponse");
  final invoice = jsonToInvoiceModel(decodedResponse);
  return ResponseInvoice(invoice: invoice);
}
