class OrderModel {
  final String id;
  final String clientCompanyId;
  final String sellerCompanyId;
  final String delegateUserId;
  final String operatorUserId;
  final String managerUserId;
  final String stockUserId;
  final String status;
  final double totalAmountExclTax;
  final double totalAmountInclTax;
  final String paymentMethod;
  final String invoiceType;
  final DateTime placedAt;
  final DateTime statusChangedAt;
  final String? clientNote;
  final String? privateNote;

  OrderModel({
    required this.id,
    required this.clientCompanyId,
    required this.sellerCompanyId,
    required this.delegateUserId,
    required this.operatorUserId,
    required this.managerUserId,
    required this.stockUserId,
    required this.status,
    required this.totalAmountExclTax,
    required this.totalAmountInclTax,
    required this.paymentMethod,
    required this.invoiceType,
    required this.placedAt,
    required this.statusChangedAt,
    this.clientNote,
    this.privateNote,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      clientCompanyId: json['client_company_id'],
      sellerCompanyId: json['seller_company_id'],
      delegateUserId: json['delegate_user_id'],
      operatorUserId: json['operator_user_id'],
      managerUserId: json['manager_user_id'],
      stockUserId: json['stock_user_id'],
      status: json['status'],
      totalAmountExclTax: (json['total_amount_excl_tax'] as num).toDouble(),
      totalAmountInclTax: (json['total_amount_incl_tax'] as num).toDouble(),
      paymentMethod: json['payment_method'],
      invoiceType: json['invoice_type'],
      placedAt: DateTime.parse(json['placed_at']),
      statusChangedAt: DateTime.parse(json['status_changed_at']),
      clientNote: json['client_note'],
      privateNote: json['private_note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_company_id': clientCompanyId,
      'seller_company_id': sellerCompanyId,
      'delegate_user_id': delegateUserId,
      'operator_user_id': operatorUserId,
      'manager_user_id': managerUserId,
      'stock_user_id': stockUserId,
      'status': status,
      'total_amount_excl_tax': totalAmountExclTax,
      'total_amount_incl_tax': totalAmountInclTax,
      'payment_method': paymentMethod,
      'invoice_type': invoiceType,
      'placed_at': placedAt.toIso8601String(),
      'status_changed_at': statusChangedAt.toIso8601String(),
      'client_note': clientNote,
      'private_note': privateNote,
    };
  }
}
