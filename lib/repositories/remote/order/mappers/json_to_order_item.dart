import 'package:hader_pharm_mobile/models/order_details.dart';

List<OrderItem> jsonToOrderItemModelList(
  List<dynamic> json,
) {
  return List<OrderItem>.from(json.map((x) => jsonToOrderItem(x)));
}

OrderItem jsonToOrderItem(Map<String, dynamic> json) {
  return OrderItem(
    id: json['id'],
    totalAmountTtc: json['totalAmountTtc'] != null ? double.parse(json['totalAmountTtc']) : 0.0,
    totalAmountHt: json['totalAmountHt'] != null ? double.parse(json['totalAmountHt']) : 0.0,
    tvaPercentage: json['tvaPercentage'] != null ? double.parse(json['tvaPercentage']) : 0.0,
    totalAppliedAmount: json['totalAppliedAmount'],
    unitPriceApplied: json['appliedAmount'] != null ? double.parse(json['appliedAmount']) : null,
    unitPriceHt: json['unitPriceHt'] != null ? double.parse(json['unitPriceHt']) : 0.0,
    unitPriceTtc: json['unitPriceTtc'] != null ? double.parse(json['unitPriceTtc']) : 0.0,
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: DateTime.parse(json['updatedAt']),
    medicineCatalogId: json['medicineCatalogId'],
    parapharmCatalogId: json['parapharmCatalogId'],
    quantity: json['quantity'],
    designation: json['designation'],
    lotNumber: json['lotNumber'],
    imageUrl: json['image']?['path'],
    packageSize: json['packageSize'] ?? 1,
    expirationDate: json['expirationDate'],
    margin: json['margin'] != null ? double.parse(json['margin']) : 0.0,
    discountAmount: json['discountAmount'] != null ? double.parse(json['discountAmount']) : 0.0,
    orderId: json['orderId'],
  );
}

OrderStatusHistory jsonToOrderStatusHistory(Map<String, dynamic> json) {
  return OrderStatusHistory(
    id: json['id'],
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: DateTime.parse(json['updatedAt']),
    orderId: json['orderId'],
    orderStatusId: json['orderStatusId'],
    changedByUserId: json['changedByUserId'],
    note: json['note'],
  );
}

List<OrderStatusHistory> jsonToOrderStatusHistoryList(List<dynamic> json) {
  return List<OrderStatusHistory>.from(json.map((x) => jsonToOrderStatusHistory(x)));
}
