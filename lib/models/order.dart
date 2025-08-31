class BaseOrderModel {
  final String id;

  final int status;
  final double totalAmountExclTax;
  final double totalAmountInclTax;
  final int? paymentMethod;
  final int? invoiceType;
  final String deliveryAddress;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double discount;
  final String? sellerCompanyName;

  BaseOrderModel({
    required this.id,
    required this.status,
    required this.totalAmountExclTax,
    required this.totalAmountInclTax,
    required this.paymentMethod,
    required this.invoiceType,
    required this.createdAt,
    required this.updatedAt,
    required this.deliveryAddress,
    required this.discount,
    this.sellerCompanyName,
  });

  factory BaseOrderModel.fromJson(Map<String, dynamic> json) {
    return BaseOrderModel(
      id: json['id'],
      status: json['status'],
      discount: json['discount'] != null ? double.parse(json['discount']) : 0.0,
      totalAmountExclTax: json['totalAmountHt'] != null
          ? double.parse(json['totalAmountHt'])
          : 0.0,
      totalAmountInclTax: json['totalAmountTtc'] != null
          ? double.parse(json['totalAmountTtc'])
          : 0.0,
      paymentMethod: json['paymentMethod'],
      deliveryAddress: json['deliveryAddress'],
      invoiceType: json['invoiceType'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      sellerCompanyName: json['companyInfo']['name'],
    );
  }
}
