import 'package:flutter/widgets.dart';
import 'package:hader_pharm_mobile/models/image.dart';

import 'company.dart';

List<CartItemModel> cartItemModelUiToData(List<CartItemModelUi> cartItems) {
  return cartItems.map((e) => e.model).toList();
}

List<CartItemModelUi> cartItemModelDataToUi(List<CartItemModel> cartItems) {
  return cartItems
      .map((e) => CartItemModelUi(
          model: e,
          quantityController: TextEditingController(
            text: e.quantity.toString(),
          ),
          packageQuantityController: TextEditingController(
            text: (e.quantity ~/ e.packageSize).toString(),
          )))
      .toList();
}

class CartItemModelUi {
  final TextEditingController quantityController;
  final TextEditingController packageQuantityController;

  final CartItemModel model;

  CartItemModelUi({
    required this.quantityController,
    required this.packageQuantityController,
    required this.model,
  });

  CartItemModelUi copyWith({required int quantity}) {
    return CartItemModelUi(
      quantityController: quantityController,
      packageQuantityController: packageQuantityController,
      model: model.copyWith(quantity: quantity),
    );
  }
}

class CartItemModel {
  final String id;
  final String totalAmountTtc;
  final String totalAmountHt;
  final String tvaPercentage;
  final String unitPriceHt;
  final String unitPriceTtc;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? medicinesCatalogId;
  final String? parapharmCatalogId;
  final int quantity;
  final int packageSize;
  final String designation;
  final dynamic lotNumber;
  final dynamic expirationDate;
  final String margin;
  final String discountAmount;
  final String buyerCompanyId;
  final String sellerCompanyId;
  final int medicineCatalogStockQty;
  final int parapharmCatalogStockQty;
  final BaseCompany sellerCompany;
  final ImageModel? image;

  CartItemModel({
    this.image,
    required this.id,
    required this.totalAmountTtc,
    required this.totalAmountHt,
    required this.tvaPercentage,
    required this.unitPriceHt,
    required this.unitPriceTtc,
    required this.createdAt,
    required this.updatedAt,
    required this.medicinesCatalogId,
    required this.parapharmCatalogId,
    required this.quantity,
    required this.designation,
    required this.lotNumber,
    required this.expirationDate,
    required this.margin,
    required this.discountAmount,
    required this.buyerCompanyId,
    required this.sellerCompanyId,
    required this.packageSize,
    this.medicineCatalogStockQty = 0,
    this.parapharmCatalogStockQty = 0,
    required this.sellerCompany,
  });

  int get packageQuantity {
    final packageCount = (quantity / packageSize).round();

    return packageCount == 0 ? 1 : packageCount;
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final thumbnailImage =
        json['medicineCatalog']?['image'] ?? json['parapharmCatalog']?['image'];

    return CartItemModel(
      packageSize: json['packageSize'] ?? 1,
      id: json['id'],
      totalAmountTtc: json['totalAmountTtc'],
      totalAmountHt: json['totalAmountHt'],
      tvaPercentage: json['tvaPercentage'],
      unitPriceHt: json['unitPriceHt'],
      unitPriceTtc: json['unitPriceTtc'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      medicinesCatalogId: json['medicineCatalogId'],
      parapharmCatalogId: json['parapharmCatalogId'],
      quantity: json['quantity'],
      designation: json['designation'],
      lotNumber: json['lotNumber'],
      expirationDate: json['expirationDate'],
      margin: json['margin'],
      discountAmount: json['discountAmount'],
      buyerCompanyId: json['buyerCompanyId'],
      sellerCompanyId: json['sellerCompanyId'],
      medicineCatalogStockQty: json['medicineCatalog']?['stockQuantity'] ?? 0,
      parapharmCatalogStockQty: json['parapharmCatalog']?['stockQuantity'] ?? 0,
      sellerCompany: BaseCompany.fromJson(json['sellerCompany']),
      image:
          thumbnailImage != null ? ImageModel.fromJson(thumbnailImage) : null,
    );
  }
  CartItemModel copyWith(
      {String? id,
      String? totalAmountTtc,
      String? totalAmountHt,
      String? tvaPercentage,
      String? unitPriceHt,
      String? unitPriceTtc,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? medicinesCatalogId,
      dynamic parapharmCatalogId,
      int? quantity,
      String? designation,
      dynamic lotNumber,
      dynamic expirationDate,
      String? margin,
      String? discountAmount,
      String? buyerCompanyId,
      String? sellerCompanyId,
      MedicinesCatalog? medicinesCatalog,
      dynamic parapharmCatalog,
      BaseCompany? sellerCompany,
      int? packageSize}) {
    return CartItemModel(
      packageSize: packageSize ?? this.packageSize,
      id: id ?? this.id,
      totalAmountTtc: totalAmountTtc ?? this.totalAmountTtc,
      totalAmountHt: totalAmountHt ?? this.totalAmountHt,
      tvaPercentage: tvaPercentage ?? this.tvaPercentage,
      unitPriceHt: unitPriceHt ?? this.unitPriceHt,
      unitPriceTtc: unitPriceTtc ?? this.unitPriceTtc,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      medicinesCatalogId: medicinesCatalogId ?? this.medicinesCatalogId,
      parapharmCatalogId: parapharmCatalogId ?? this.parapharmCatalogId,
      quantity: quantity ?? this.quantity,
      designation: designation ?? this.designation,
      lotNumber: lotNumber ?? this.lotNumber,
      expirationDate: expirationDate ?? this.expirationDate,
      margin: margin ?? this.margin,
      discountAmount: discountAmount ?? this.discountAmount,
      buyerCompanyId: buyerCompanyId ?? this.buyerCompanyId,
      sellerCompanyId: sellerCompanyId ?? this.sellerCompanyId,
      sellerCompany: sellerCompany ?? this.sellerCompany,
    );
  }

  Map<String, num> getTotalPrice() {
    num totalHtPrice = num.parse(unitPriceHt) * quantity;
    num totalTTCPrice = num.parse(unitPriceTtc) * quantity;
    return <String, num>{
      "totalHtPrice": totalHtPrice,
      "totalTTCPrice": totalTTCPrice
    };
  }
}

class MedicinesCatalog {
  final String unitPriceTtc;
  final String unitPriceHt;
  final String tvaPercentage;
  final String dci;
  final int stockQuantity;

  MedicinesCatalog({
    required this.unitPriceTtc,
    required this.unitPriceHt,
    required this.tvaPercentage,
    required this.dci,
    required this.stockQuantity,
  });

  factory MedicinesCatalog.fromJson(Map<String, dynamic> json) {
    return MedicinesCatalog(
      unitPriceTtc: json['unitPriceTtc'],
      unitPriceHt: json['unitPriceHt'],
      tvaPercentage: json['tvaPercentage'],
      dci: json['dci'],
      stockQuantity: json['stockQuantity'] ?? 0,
    );
  }
}
