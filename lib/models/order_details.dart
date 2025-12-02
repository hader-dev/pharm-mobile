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
    required super.totalAppliedAmountHt,
    required super.totalAppliedAmountTtc,
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
      totalAppliedAmountHt: 0.0,
      totalAppliedAmountTtc: 0.0,
    );
  }
}

class OrderItem {
  final String id;
  final double totalAmountTtc;
  final double totalAmountHt;
  final double appliedAmountTtc;
  final double appliedAmountHt;
  final double tvaPercentage;
  final double unitPriceHt;
  final double unitPriceTtc;
  final double customPriceHt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? medicineCatalogId;
  final String? paraPharmCatalogId;
  final int quantity;
  final dynamic designation;
  final dynamic lotNumber;
  final dynamic expirationDate;
  final double margin;
  final double discountAmountHt;
  final int packageSize;
  final String orderId;
  final double? unitPriceApplied;
  final double? totalAppliedAmountHt;
  final double? totalAppliedAmountTtc;

  final String? imageUrl;

  final String? note;

  OrderItem({
    required this.id,
    this.note,
    this.unitPriceApplied,
    required this.totalAmountTtc,
    required this.totalAppliedAmountHt,
    required this.totalAppliedAmountTtc,
    required this.totalAmountHt,
    required this.tvaPercentage,
    required this.unitPriceHt,
    required this.appliedAmountHt,
    required this.appliedAmountTtc,
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
    required this.discountAmountHt,
    required this.orderId,
    this.imageUrl,
    this.customPriceHt = 0.0,
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
      totalAppliedAmountHt: 0.0,
      packageSize: 0,
      designation: null,
      lotNumber: null,
      expirationDate: null,
      margin: 0.0,
      discountAmountHt: 0.0,
      orderId: '',
      imageUrl: null,
      note: null,
      appliedAmountHt: 0.0,
      appliedAmountTtc: 0.0,
      totalAppliedAmountTtc: 0.0,
      unitPriceApplied: 0.0,
      customPriceHt: 0.0,
    );
  }

  OrderItem copyWith({
    String? id,
    String? note,
    double? unitPriceApplied,
    double? totalAmountTtc,
    double? totalAppliedAmountHt,
    double? totalAppliedAmountTtc,
    double? totalAmountHt,
    double? tvaPercentage,
    double? unitPriceHt,
    double? appliedAmountHt,
    double? appliedAmountTtc,
    double? unitPriceTtc,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? medicineCatalogId,
    String? paraPharmCatalogId,
    int? quantity,
    String? designation,
    int? packageSize,
    dynamic lotNumber,
    dynamic expirationDate,
    double? margin,
    double? discountAmountHt,
    String? orderId,
    String? imageUrl,
    double? customPriceHt = 0.0,
  }) {
    return OrderItem(
      id: id ?? this.id,
      note: note ?? this.note,
      unitPriceApplied: unitPriceApplied ?? this.unitPriceApplied,
      totalAmountTtc: totalAmountTtc ?? this.totalAmountTtc,
      totalAppliedAmountHt: totalAppliedAmountHt ?? this.totalAppliedAmountHt,
      totalAppliedAmountTtc: totalAppliedAmountTtc ?? this.totalAppliedAmountTtc,
      totalAmountHt: totalAmountHt ?? this.totalAmountHt,
      tvaPercentage: tvaPercentage ?? this.tvaPercentage,
      unitPriceHt: unitPriceHt ?? this.unitPriceHt,
      appliedAmountHt: appliedAmountHt ?? this.appliedAmountHt,
      appliedAmountTtc: appliedAmountTtc ?? this.appliedAmountTtc,
      unitPriceTtc: unitPriceTtc ?? this.unitPriceTtc,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      medicineCatalogId: medicineCatalogId ?? this.medicineCatalogId,
      paraPharmCatalogId: paraPharmCatalogId ?? this.paraPharmCatalogId,
      quantity: quantity ?? this.quantity,
      designation: designation ?? this.designation,
      packageSize: packageSize ?? this.packageSize,
      lotNumber: lotNumber ?? this.lotNumber,
      expirationDate: expirationDate ?? this.expirationDate,
      margin: margin ?? this.margin,
      discountAmountHt: discountAmountHt ?? this.discountAmountHt,
      orderId: orderId ?? this.orderId,
      imageUrl: imageUrl ?? this.imageUrl,
      customPriceHt: customPriceHt ?? this.customPriceHt,
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
