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

  const OrderDetailsModel({
    required super.id,
    super.invoiceType,
    super.paymentMethod,
    required super.discount,
    required super.createdAt,
    required super.updatedAt,
    required super.deliveryAddress,
    required super.status,
    super.totalAppliedAmount,
    required super.totalAmountExclTax,
    required super.totalAmountInclTax,
    required this.latitude,
    required this.longitude,
    required this.clientCompanyId,
    required this.sellerCompanyId,
    required this.delegateUserId,
    required this.operatorUserId,
    required this.stockUserId,
    required super.displayId,
    required this.deliveryTownId,
    required this.clientNote,
    required this.privateNote,
    required this.orderItems,
    required this.orderStatusHistories,
    required this.clientCompany,
    required this.sellerCompany,
  });

  factory OrderDetailsModel.empty() {
    return OrderDetailsModel(
      id: "empty",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      invoiceType: 0,
      paymentMethod: 0,
      discount: 0.0,
      displayId: "",
      deliveryAddress: "",
      status: 1,
      totalAmountExclTax: 0.0,
      totalAmountInclTax: 0.0,
      latitude: 0.0,
      longitude: 0.0,
      clientCompanyId: "",
      sellerCompanyId: "",
      delegateUserId: "",
      operatorUserId: "",
      stockUserId: "",
      deliveryTownId: 0,
      clientNote: "",
      privateNote: "",
      orderItems: [],
      orderStatusHistories: [],
      clientCompany: Company.empty(),
      sellerCompany: Company.empty(),
    );
  }
}

class OrderItem {
  final String id;
  final double totalAmountTtc;
  final double totalAmountHt;
  final double tvaPercentage;
  final double unitPriceHt;
  final double unitPriceTtc;
  final double customPrice;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? medicineCatalogId;
  final String? paraPharmCatalogId;
  final int quantity;
  final dynamic designation;
  final dynamic lotNumber;
  final dynamic expirationDate;
  final double margin;
  final double discountAmount;
  final int packageSize;
  final String orderId;
  final double? unitPriceApplied;
  final double? totalAppliedAmount;

  final String? imageUrl;

  final String? note;

  OrderItem({
    required this.id,
    this.note,
    this.unitPriceApplied,
    required this.totalAmountTtc,
    required this.totalAppliedAmount,
    required this.totalAmountHt,
    required this.tvaPercentage,
    required this.unitPriceHt,
    required this.unitPriceTtc,
    required this.createdAt,
    required this.updatedAt,
    required this.medicineCatalogId,
    required this.paraPharmCatalogId,
    required this.quantity,
    required this.designation,
    required this.packageSize,
    required this.lotNumber,
    required this.expirationDate,
    required this.margin,
    required this.discountAmount,
    required this.orderId,
    this.imageUrl,
    this.customPrice = 0.0,
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
      paraPharmCatalogId: null,
      quantity: 0,
      totalAppliedAmount: 0.0,
      packageSize: 0,
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
      totalAppliedAmount: 13.20,
      packageSize: 10,
      unitPriceTtc: 13.20,
      createdAt: DateTime.now().subtract(Duration(days: 10)),
      updatedAt: DateTime.now(),
      medicineCatalogId: 'med_123',
      paraPharmCatalogId: null,
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

  OrderItem copyWith({
    String? id,
    double? totalAmountTtc,
    double? totalAmountHt,
    double? tvaPercentage,
    double? unitPriceHt,
    double? unitPriceTtc,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? medicineCatalogId,
    String? parapharmCatalogId,
    int? quantity,
    dynamic designation,
    dynamic lotNumber,
    dynamic expirationDate,
    double? margin,
    double? discountAmount,
    String? orderId,
    String? imageUrl,
    int? packageSize,
    String? note,
  }) {
    return OrderItem(
        id: id ?? this.id,
        packageSize: packageSize ?? this.packageSize,
        totalAmountTtc: totalAmountTtc ?? this.totalAmountTtc,
        totalAmountHt: totalAmountHt ?? this.totalAmountHt,
        tvaPercentage: tvaPercentage ?? this.tvaPercentage,
        unitPriceHt: unitPriceHt ?? this.unitPriceHt,
        unitPriceTtc: unitPriceTtc ?? this.unitPriceTtc,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        medicineCatalogId: medicineCatalogId ?? this.medicineCatalogId,
        paraPharmCatalogId: parapharmCatalogId ?? paraPharmCatalogId,
        quantity: quantity ?? this.quantity,
        designation: designation ?? this.designation,
        lotNumber: lotNumber ?? this.lotNumber,
        expirationDate: expirationDate ?? this.expirationDate,
        margin: margin ?? this.margin,
        discountAmount: discountAmount ?? this.discountAmount,
        orderId: orderId ?? this.orderId,
        imageUrl: imageUrl ?? this.imageUrl,
        note: note ?? this.note,
        totalAppliedAmount: totalAppliedAmount);
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
