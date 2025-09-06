import 'company.dart';
import 'order.dart';

class OrderDetailsModel extends BaseOrderModel {
  final double latitude;
  final double longitude;

  final String clientCompanyId;
  final String sellerCompanyId;
  final dynamic delegateUserId;
  final dynamic operatorUserId;
  final dynamic stockUserId;

  final int deliveryTownId;
  final String clientNote;
  final String privateNote;

  final List<OrderItem> orderItems;
  final List<OrderStatusHistory> orderStatusHistories;
  final Company clientCompany;
  final Company sellerCompany;

  OrderDetailsModel({
    required super.id,
    super.invoiceType,
    super.paymentMethod,
    required super.discount,
    required super.createdAt,
    required super.updatedAt,
    required super.deliveryAddress,
    required super.status,
    required super.totalAmountExclTax,
    required super.totalAmountInclTax,
    required this.latitude,
    required this.longitude,
    required this.clientCompanyId,
    required this.sellerCompanyId,
    required this.delegateUserId,
    required this.operatorUserId,
    required this.stockUserId,
    required this.deliveryTownId,
    required this.clientNote,
    required this.privateNote,
    required this.orderItems,
    required this.orderStatusHistories,
    required this.clientCompany,
    required this.sellerCompany,
  });
}

class OrderItem {
  final String id;
  final double totalAmountTtc;
  final double totalAmountHt;
  final double tvaPercentage;
  final double unitPriceHt;
  final double unitPriceTtc;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? medicineCatalogId;
  final String? parapharmCatalogId;
  final int quantity;
  final dynamic designation;
  final dynamic lotNumber;
  final dynamic expirationDate;
  final double margin;
  final double discountAmount;
  final String orderId;

  final String? imageUrl;

  final String? note;

  OrderItem({
    required this.id,
    this.note,
    required this.totalAmountTtc,
    required this.totalAmountHt,
    required this.tvaPercentage,
    required this.unitPriceHt,
    required this.unitPriceTtc,
    required this.createdAt,
    required this.updatedAt,
    required this.medicineCatalogId,
    required this.parapharmCatalogId,
    required this.quantity,
    required this.designation,
    required this.lotNumber,
    required this.expirationDate,
    required this.margin,
    required this.discountAmount,
    required this.orderId,
    this.imageUrl,
  });

  factory OrderItem.empty() {
    return OrderItem(
      id: '',
      totalAmountTtc: 0.0,
      totalAmountHt: 0.0,
      tvaPercentage: 0.0,
      unitPriceHt: 0.0,
      unitPriceTtc: 0.0,
      createdAt: DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
      medicineCatalogId: null,
      parapharmCatalogId: null,
      quantity: 0,
      designation: null,
      lotNumber: null,
      expirationDate: null,
      margin: 0.0,
      discountAmount: 0.0,
      orderId: '',
      imageUrl: null,
      note: null,
    );
  }

  factory OrderItem.mock() {
    return OrderItem(
      id: 'item_001',
      totalAmountTtc: 132.00,
      totalAmountHt: 120.00,
      tvaPercentage: 10.0,
      unitPriceHt: 12.00,
      unitPriceTtc: 13.20,
      createdAt: DateTime.now().subtract(Duration(days: 10)),
      updatedAt: DateTime.now(),
      medicineCatalogId: 'med_123',
      parapharmCatalogId: null,
      quantity: 10,
      designation: 'Mock Medicine',
      lotNumber: 'LOT2025A',
      expirationDate: DateTime.now().add(Duration(days: 365)),
      margin: 5.0,
      discountAmount: 10.0,
      orderId: 'order_001',
      imageUrl: 'https://example.com/product.jpg',
      note: 'Urgent delivery',
    );
  }
}

class OrderStatusHistory {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String orderId;
  final int orderStatusId;
  final dynamic changedByUserId;
  final dynamic note;

  OrderStatusHistory({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.orderId,
    required this.orderStatusId,
    required this.changedByUserId,
    required this.note,
  });
}
