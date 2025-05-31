class Order {
  final int orderId;
  final String? note;
  final double discount;
  final int discountPercentage;
  final String clientFirstName;
  final String clientLastName;
  final String deliveryAddress;
  final String clientMobile;
  final String clientFax;
  final String clientPhone;
  final double stampDuty;
  final double amountHt;
  final double netAmountTtc;
  final double netToPay;
  final double totalTva;
  final String? ref;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int clientId;
  final int paymentMethodId;
  final int status;
  final double latitude;
  final double longitude;

  // final List<OrderItem> orderItems;
  // final List<TrackingHistory> trackingHistory;

  Order({
    required this.orderId,
    this.note,
    required this.discount,
    required this.discountPercentage,
    required this.clientFirstName,
    required this.clientLastName,
    required this.deliveryAddress,
    required this.clientMobile,
    required this.clientFax,
    required this.clientPhone,
    required this.stampDuty,
    required this.amountHt,
    required this.netAmountTtc,
    required this.netToPay,
    required this.totalTva,
    this.ref,
    required this.createdAt,
    required this.updatedAt,
    required this.clientId,
    required this.paymentMethodId,
    required this.status,
    required this.latitude,
    required this.longitude,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['id'],
      note: json['note'],
      discount: double.parse(json['discount']),
      discountPercentage: json['discountPercentage'],
      clientFirstName: json['clientFirstName'],
      clientLastName: json['clientLastName'],
      deliveryAddress: json['deliveryAddress'],
      clientMobile: json['clientMobile'],
      clientFax: json['clientFax'],
      clientPhone: json['clientPhone'],
      stampDuty: double.parse(json['stampDuty']),
      amountHt: double.parse(json['amountHt']),
      netAmountTtc: double.parse(json['netAmountTtc']),
      netToPay: double.parse(json['netToPay']),
      totalTva: double.parse(json['totalTva']),
      ref: json['ref'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      clientId: json['clientId'],
      paymentMethodId: json['paymentMethodId'],
      status: json['statusId'],
      latitude: double.parse(json['latitude'] ?? "0.0"),
      longitude: double.parse(json['longitude'] ?? "0.0"),
    );
  }
}

class Status {
  final int statusId;
  final String label;

  Status({
    required this.statusId,
    required this.label,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      statusId: json['status_id'],
      label: json['label'],
    );
  }
}
