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
            text: (e.quantity ~/ (e.packageSize > 0 ? e.packageSize : 1)).toString(),
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
  final String? paraPharmCatalogId;
  final int quantity;
  final String designation;
  final dynamic lotNumber;
  final dynamic expirationDate;
  final String margin;
  final String discountAmountHt;
  final int packageSize;
  final String customPriceHt;
  final String appliedAmountHt;
  final String appliedAmountTtc;
  final String totalAppliedAmountHt;
  final String totalAppliedAmountTtc;
  final String buyerCompanyId;
  final String sellerCompanyId;
  final int medicineCatalogStockQty;
  final int paraPharmCatalogStockQty;
  final BaseCompany sellerCompany;
  final ImageModel? image;
  final int maxOrderQuantity;
  final int minOrderQuantity;

  CartItemModel({
    this.image,
    required this.id,
    required this.totalAppliedAmountHt,
    required this.totalAppliedAmountTtc,
    required this.appliedAmountHt,
    required this.appliedAmountTtc,
    required this.maxOrderQuantity,
    required this.minOrderQuantity,
    required this.totalAmountTtc,
    required this.totalAmountHt,
    required this.tvaPercentage,
    required this.unitPriceHt,
    required this.unitPriceTtc,
    required this.createdAt,
    required this.updatedAt,
    required this.medicinesCatalogId,
    required this.paraPharmCatalogId,
    required this.quantity,
    required this.designation,
    required this.lotNumber,
    required this.expirationDate,
    required this.margin,
    required this.discountAmountHt,
    required this.buyerCompanyId,
    required this.sellerCompanyId,
    required this.packageSize,
    this.medicineCatalogStockQty = 0,
    this.paraPharmCatalogStockQty = 0,
    required this.sellerCompany,
    this.customPriceHt = '0',
  });

  int get packageQuantity {
    final packageCount = (quantity / packageSize).round();

    return packageCount == 0 ? 1 : packageCount;
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final thumbnailImage = json['medicineCatalog']?['image'] ?? json['parapharmCatalog']?['image'];
    final minOrderQuantity = json['medicineCatalog'] != null
        ? json['medicineCatalog']!['minOrderQuantity'] ?? 1
        : json['parapharmCatalog']!['minOrderQuantity'] ?? 1;

    final maxOrderQuantity = json['medicineCatalog'] != null
        ? json['medicineCatalog']!['maxOrderQuantity'] ?? 9999
        : json['parapharmCatalog']!['maxOrderQuantity'] ?? 9999;

    int packageSize = json['packageSize'] ?? 1;
    packageSize = packageSize == 0 ? 1 : packageSize;

    return CartItemModel(
      packageSize: packageSize,
      id: json['id'],
      maxOrderQuantity: maxOrderQuantity,
      totalAppliedAmountHt: json['totalAppliedAmountHt'] ?? "0",
      totalAppliedAmountTtc: json['totalAppliedAmountTtc'] ?? "0",
      minOrderQuantity: minOrderQuantity,
      totalAmountTtc: json['totalAmountTtc'],
      totalAmountHt: json['totalAmountHt'],
      tvaPercentage: json['tvaPercentage'],
      unitPriceHt: json['unitPriceHt'],
      unitPriceTtc: json['unitPriceTtc'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      medicinesCatalogId: json['medicineCatalogId'],
      paraPharmCatalogId: json['parapharmCatalogId'],
      quantity: json['quantity'],
      designation: json['designation'],
      lotNumber: json['lotNumber'],
      expirationDate: json['expirationDate'],
      margin: json['margin'],
      discountAmountHt: json['discountAmountHt'],
      buyerCompanyId: json['buyerCompanyId'],
      sellerCompanyId: json['sellerCompanyId'],
      appliedAmountHt: json['appliedAmountHt'] ?? "0",
      appliedAmountTtc: json['appliedAmountTtc'] ?? "0",
      medicineCatalogStockQty: json['medicineCatalog']?['actualQuantity'] ?? 0,
      paraPharmCatalogStockQty: json['parapharmCatalog']?['actualQuantity'] ?? 0,
      sellerCompany: BaseCompany.fromJson(json['sellerCompany']),
      image: thumbnailImage != null ? ImageModel.fromJson(thumbnailImage) : null,
      customPriceHt: json['customPriceHt'] ?? '0',
    );
  }
  CartItemModel copyWith({
    String? id,
    String? totalAmountTtc,
    String? totalAmountHt,
    String? tvaPercentage,
    String? unitPriceHt,
    String? unitPriceTtc,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? medicinesCatalogId,
    String? paraPharmCatalogId,
    int? quantity,
    String? designation,
    dynamic lotNumber,
    dynamic expirationDate,
    String? margin,
    String? discountAmountHt,
    int? packageSize,
    String? customPriceHt,
    String? appliedAmountHt,
    String? appliedAmountTtc,
    String? totalAppliedAmountHt,
    String? totalAppliedAmountTtc,
    String? buyerCompanyId,
    String? sellerCompanyId,
    int? medicineCatalogStockQty,
    int? paraPharmCatalogStockQty,
    BaseCompany? sellerCompany,
    ImageModel? image,
    int? maxOrderQuantity,
    int? minOrderQuantity,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      totalAmountTtc: totalAmountTtc ?? this.totalAmountTtc,
      totalAmountHt: totalAmountHt ?? this.totalAmountHt,
      tvaPercentage: tvaPercentage ?? this.tvaPercentage,
      unitPriceHt: unitPriceHt ?? this.unitPriceHt,
      unitPriceTtc: unitPriceTtc ?? this.unitPriceTtc,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      medicinesCatalogId: medicinesCatalogId ?? this.medicinesCatalogId,
      paraPharmCatalogId: paraPharmCatalogId ?? this.paraPharmCatalogId,
      quantity: quantity ?? this.quantity,
      designation: designation ?? this.designation,
      lotNumber: lotNumber ?? this.lotNumber,
      expirationDate: expirationDate ?? this.expirationDate,
      margin: margin ?? this.margin,
      discountAmountHt: discountAmountHt ?? this.discountAmountHt,
      packageSize: packageSize ?? this.packageSize,
      customPriceHt: customPriceHt ?? this.customPriceHt,
      appliedAmountHt: appliedAmountHt ?? this.appliedAmountHt,
      appliedAmountTtc: appliedAmountTtc ?? this.appliedAmountTtc,
      totalAppliedAmountHt: totalAppliedAmountHt ?? this.totalAppliedAmountHt,
      totalAppliedAmountTtc: totalAppliedAmountTtc ?? this.totalAppliedAmountTtc,
      buyerCompanyId: buyerCompanyId ?? this.buyerCompanyId,
      sellerCompanyId: sellerCompanyId ?? this.sellerCompanyId,
      medicineCatalogStockQty: medicineCatalogStockQty ?? this.medicineCatalogStockQty,
      paraPharmCatalogStockQty: paraPharmCatalogStockQty ?? this.paraPharmCatalogStockQty,
      sellerCompany: sellerCompany ?? this.sellerCompany,
      image: image ?? this.image,
      maxOrderQuantity: maxOrderQuantity ?? this.maxOrderQuantity,
      minOrderQuantity: minOrderQuantity ?? this.minOrderQuantity,
    );
  }

  Map<String, num> getTotalPrice() {
    return <String, num>{
      "totalHtPrice": double.parse(appliedAmountHt) * quantity,
      "totalTTCPrice": double.parse(appliedAmountTtc) * quantity
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
      stockQuantity: json['actualQuantity'] ?? 0,
    );
  }
}
