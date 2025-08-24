import 'package:hader_pharm_mobile/repositories/remote/company/mappers/json_to_company.dart';

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

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        id: json['id'],
        invoiceType: json['invoiceType'],
        paymentMethod: json['paymentMethod'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        deliveryAddress: json['deliveryAddress'],
        status: json['status'],
        totalAmountExclTax: json['totalAmountHt'] != null
            ? double.parse(json['totalAmountHt'])
            : 0.0,
        totalAmountInclTax: json['totalAmountTtc '] != null
            ? double.parse(json['totalAmountTtc'])
            : 0.0,
        latitude:
            json['latitude'] != null ? double.parse(json['latitude']) : 0.0,
        longitude:
            json['longitude'] != null ? double.parse(json['longitude']) : 0.0,
        clientCompanyId: json['clientCompanyId'],
        sellerCompanyId: json['sellerCompanyId'],
        delegateUserId: json['delegateUserId'],
        operatorUserId: json['operatorUserId'],
        stockUserId: json['stockUserId'],
        deliveryTownId: json['deliveryTownId'],
        clientNote: json['clientNote'] ?? "",
        privateNote: json['privateNote'] ?? "",
        orderItems: List<OrderItem>.from(
            json['orderItems'].map((x) => OrderItem.fromJson(x))),
        orderStatusHistories: List<OrderStatusHistory>.from(
            (json['orderStatusHistories'] as List)
                .map((x) => OrderStatusHistory.fromJson(x))),
        clientCompany: jsonToCompany(json['clientCompany']),
        sellerCompany: jsonToCompany(json['sellerCompany']),
      );
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

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json['id'],
        totalAmountTtc: json['totalAmountTtc'] != null
            ? double.parse(json['totalAmountTtc'])
            : 0.0,
        totalAmountHt: json['totalAmountHt'] != null
            ? double.parse(json['totalAmountHt'])
            : 0.0,
        tvaPercentage: json['tvaPercentage'] != null
            ? double.parse(json['tvaPercentage'])
            : 0.0,
        unitPriceHt: json['unitPriceHt'] != null
            ? double.parse(json['unitPriceHt'])
            : 0.0,
        unitPriceTtc: json['unitPriceTtc'] != null
            ? double.parse(json['unitPriceTtc'])
            : 0.0,
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        medicineCatalogId: json['medicineCatalogId'],
        parapharmCatalogId: json['parapharmCatalogId'],
        quantity: json['quantity'],
        designation: json['designation'],
        lotNumber: json['lotNumber'],
        imageUrl: json['thumbnailImage']?['path'],
        expirationDate: json['expirationDate'],
        margin: json['margin'] != null ? double.parse(json['margin']) : 0.0,
        discountAmount: json['discountAmount'] != null
            ? double.parse(json['discountAmount'])
            : 0.0,
        orderId: json['orderId'],
      );
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
  factory OrderStatusHistory.fromJson(Map<String, dynamic> json) =>
      OrderStatusHistory(
        id: json['id'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        orderId: json['orderId'],
        orderStatusId: json['orderStatusId'],
        changedByUserId: json['changedByUserId'],
        note: json['note'],
      );
}
