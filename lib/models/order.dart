class BaseOrderModel {
  final String id;

  final int status;
  final double totalAmountExclTax;
  final double totalAmountInclTax;
  final double totalAppliedAmountHt;
  final double totalAppliedAmountTtc;
  final int? paymentMethod;
  final int? invoiceType;
  final String deliveryAddress;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final double discount;
  final String? sellerCompanyName;
  final String? clientCompanyName;
  final String displayId;
  final double? totalAppliedAmount;

  const BaseOrderModel({
    required this.id,
    this.clientCompanyName,
    required this.displayId,
    this.totalAppliedAmount,
    required this.status,
    required this.totalAmountExclTax,
    required this.totalAmountInclTax,
    required this.totalAppliedAmountHt,
    required this.totalAppliedAmountTtc,
    required this.paymentMethod,
    required this.invoiceType,
    required this.createdAt,
    this.updatedAt,
    required this.deliveryAddress,
    required this.discount,
    this.sellerCompanyName,
  });

  factory BaseOrderModel.fromJson(Map<String, dynamic> json) {
    return BaseOrderModel(
      displayId: json['displayId'],
      id: json['id'],
      status: json['status'],
      discount: json['discount'] != null ? double.parse(json['discount']) : 0.0,
      totalAmountExclTax: json['totalAmountHt'] != null
          ? double.parse(json['totalAmountHt'])
          : 0.0,
      totalAmountInclTax: json['totalAmountTtc'] != null
          ? double.parse(json['totalAmountTtc'])
          : 0.0,
      totalAppliedAmountHt: json['totalAppliedAmountHt'] != null
          ? double.parse(json['totalAppliedAmountHt'])
          : 0.0,
      totalAppliedAmountTtc: json['totalAppliedAmountTtc'] != null
          ? double.parse(json['totalAppliedAmountTtc'])
          : 0.0,
      paymentMethod: json['paymentMethod'],
      deliveryAddress: json['deliveryAddress'],
      invoiceType: json['invoiceType'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      sellerCompanyName: json['sellerCompany']?['name'],
      clientCompanyName: json['clientCompany']?['name'],
    );
  }

  factory BaseOrderModel.empty() {
    return BaseOrderModel(
      id: '',
      status: 0,
      displayId: '',
      totalAmountExclTax: 0.0,
      totalAmountInclTax: 0.0,
      paymentMethod: null,
      invoiceType: null,
      deliveryAddress: '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
      discount: 0.0,
      sellerCompanyName: null,
      clientCompanyName: null,
      totalAppliedAmountHt: 0.0,
      totalAppliedAmountTtc: 0.0,
      totalAppliedAmount: 0.0,
    );
  }
}
