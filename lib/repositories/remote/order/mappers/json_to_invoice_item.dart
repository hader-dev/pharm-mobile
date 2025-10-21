import 'package:hader_pharm_mobile/models/invoice.dart';

InvoiceItem jsonToInvoiceItem(Map<String, dynamic> json) {
  return InvoiceItem(
    id: json['id'],
    quantity: json['quantity'],
    lotNumber: json['lotNumber'],
    ppa: json['ppa'],
    shp: json['shp'],
    designation: '',
    puHt: '',
    expiry: '',
    tva: '',
    mge: '',
    mtHt: '',
  );
}

List<InvoiceItem> jsonToInvoiceItemModelList(List<dynamic> json) {
  return List<InvoiceItem>.from(json.map((x) => jsonToInvoiceItem(x)));
}
