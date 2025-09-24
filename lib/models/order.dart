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
  final String? clientCompanyName;

  BaseOrderModel({
    required this.id,
    this.clientCompanyName,
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
      clientCompanyName: json['clientCompany']['name'],
    );
  }

  factory BaseOrderModel.empty() {
    return BaseOrderModel(
      id: '',
      status: 0,
      totalAmountExclTax: 0.0,
      totalAmountInclTax: 0.0,
      paymentMethod: null,
      invoiceType: null,
      deliveryAddress: '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
      discount: 0.0,
      sellerCompanyName: null,
    );
  }

  factory BaseOrderModel.mock() {
    return BaseOrderModel(
      id: 'order_001',
      status: 1,
      totalAmountExclTax: 1200.50,
      totalAmountInclTax: 1320.55,
      paymentMethod: 2,
      invoiceType: 1,
      deliveryAddress: '456 Example Ave, Mock City',
      createdAt: DateTime.now().subtract(Duration(days: 15)),
      updatedAt: DateTime.now(),
      discount: 50.00,
      clientCompanyName: 'Mock Client Co.',
      sellerCompanyName: 'Mock Seller Co.',
    );
  }
}
