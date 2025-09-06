import 'package:hader_pharm_mobile/models/invoice.dart';
import 'package:hader_pharm_mobile/models/order.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/mappers/json_to_company.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/mappers/json_to_invoice_item.dart';
import 'package:hader_pharm_mobile/repositories/remote/user/mappers/json_to_user.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';

Invoice jsonToInvoiceModel(Map<String, dynamic> json) {
  return Invoice(
    orderId: json["orderId"] ?? "0",
    invoiceNumber: json["invoiceNumber"] ?? "0",
    invoiceYear: json["invoiceYear"] ?? 0,
    issuedByUserId: json["issuedByUserId"] ?? "0",
    issueDate: DateTime.parse(json["issueDate"]),
    dueDate: json["dueDate"] != null ? DateTime.parse(json["dueDate"]) : null,
    paymentMethod: json["paymentMethod"] != null
        ? PaymentMethods.values.byName(json["paymentMethod"])
        : null,
    paymentStatus: json["paymentStatus"],
    invoiceType: InvoiceTypes.values.byName(json["invoiceType"]),
    stampDutyAmount: double.tryParse(json["stampDutyAmount"].toString()) ?? 0.0,
    totalVatAmount: double.tryParse(json["totalVatAmount"].toString()) ?? 0.0,
    paidAt: json["paidAt"] != null ? DateTime.parse(json["paidAt"]) : null,
    notes: json["notes"],
    order: BaseOrderModel.fromJson(json["order"]),
    issuedByUser: jsonToUser(json["issuedByUser"]),
    sellerCompany: json["sellerCompany"] != null
        ? jsonToCompany(json["sellerCompany"])
        : null,
    clientCompany: json["clientCompany"] != null
        ? jsonToCompany(json["clientCompany"])
        : null,
    invoiceItems: json["orderItems"] != null
        ? jsonToInvoiceItemModelList(json["orderItems"])
        : null,
    id: json["json"],
    invoiceSummary: json["invoiceSummary"] != null
        ? jsonToInvoiceSummary(json["invoiceSummary"])
        : InvoiceSummary.mock(),
  );
}

InvoiceSummary jsonToInvoiceSummary(Map<String, dynamic> json) {
  return InvoiceSummary(
    totalItems: json["totalItems"],
    totalShipping: json["totalShipping"],
    totalPpa: json["totalPpa"],
    totalRist: json["totalRist"],
    totalExclTax: json["totalExclTax"],
    vatAmount: json["vatAmount"],
    stampDuty: json["stampDuty"],
    netToPay: json["netToPay"],
  );
}
