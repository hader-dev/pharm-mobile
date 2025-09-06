import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/models/order.dart';
import 'package:hader_pharm_mobile/models/user.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';

class Invoice {
  final String orderId;
  final String id;
  final String invoiceNumber;
  final int invoiceYear;
  final String issuedByUserId;
  final DateTime issueDate;
  final DateTime? dueDate;
  final PaymentMethods? paymentMethod;
  final int paymentStatus;
  final InvoiceTypes invoiceType;
  final double stampDutyAmount;
  final double totalVatAmount;
  final DateTime? paidAt;
  final String? notes;

  final BaseOrderModel order;
  final UserModel issuedByUser;

  final Company? sellerCompany;
  final Company? clientCompany;
  final List<InvoiceItem>? invoiceItems;

  final InvoiceSummary invoiceSummary;

  Invoice({
    required this.orderId,
    required this.id,
    required this.invoiceNumber,
    required this.invoiceYear,
    required this.issuedByUserId,
    required this.issueDate,
    this.dueDate,
    this.paymentMethod,
    required this.invoiceSummary,
    required this.paymentStatus,
    required this.invoiceType,
    required this.stampDutyAmount,
    required this.totalVatAmount,
    this.paidAt,
    this.notes,
    required this.order,
    required this.issuedByUser,
    this.sellerCompany,
    this.clientCompany,
    this.invoiceItems,
  });

  String get formattedInvoiceNumber {
    final yearShort = invoiceYear.toString().substring(2);
    final typeCode = invoiceType.name[0].toUpperCase();
    final numberPadded = invoiceNumber.toString().padLeft(6, '0');
    return '$yearShort/$typeCode-$numberPadded';
  }
}

class InvoiceSummary {
  final double totalExclTax;
  final double vatAmount;
  final double stampDuty;
  final double netToPay;

  final double totalItems;
  final double totalRist;
  final double totalShipping;
  final double totalPpa;
  final String amountInWords;

  InvoiceSummary(
      {required this.totalExclTax,
      required this.vatAmount,
      this.totalItems = 0,
      this.totalRist = 0,
      this.amountInWords = '',
      this.totalShipping = 0,
      this.totalPpa = 0,
      required this.stampDuty,
      required this.netToPay});

  factory InvoiceSummary.mock() {
    return InvoiceSummary(
      totalExclTax: 0,
      vatAmount: 0,
      totalItems: 0,
      totalRist: 0,
      totalShipping: 0,
      totalPpa: 0,
      stampDuty: 0,
      netToPay: 0,
    );
  }
}

class InvoiceItem {
  final String designation;
  final int quantity;
  final String lotNumber;
  final String ppa;
  final String shp;
  final String puHt;
  final String expiry;
  final String tva;
  final String mge;
  final String mtHt;
  final String id;

  InvoiceItem({
    required this.designation,
    required this.quantity,
    required this.lotNumber,
    required this.ppa,
    required this.shp,
    required this.puHt,
    required this.id,
    required this.expiry,
    required this.tva,
    required this.mge,
    required this.mtHt,
  });

  factory InvoiceItem.empty() {
    return InvoiceItem(
      id: '',
      designation: '',
      quantity: 0,
      lotNumber: '',
      ppa: "0.0",
      shp: "0.0",
      puHt: "0.0",
      expiry: '',
      tva: "0.0",
      mge: "0.0",
      mtHt: "0.0",
    );
  }

  factory InvoiceItem.mock() {
    return InvoiceItem(
      id: '1',
      designation: 'Paracetamol 500mg',
      quantity: 10,
      lotNumber: 'LOT123',
      ppa: "15.0",
      shp: "18.0",
      puHt: "17.0",
      expiry: '12/2026',
      tva: "9.0",
      mge: "5.0",
      mtHt: "170.0",
    );
  }
}
