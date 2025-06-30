import 'company.dart';

class CartItemModel {
  final String id;
  final String totalAmountTtc;
  final String totalAmountHt;
  final String tvaPercentage;
  final String unitPriceHt;
  final String unitPriceTtc;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String medicinesCatalogId;
  final dynamic parapharmCatalogId;
  final int quantity;
  final String designation;
  final dynamic lotNumber;
  final dynamic expirationDate;
  final String margin;
  final String discountAmount;
  final String buyerCompanyId;
  final String sellerCompanyId;
  final MedicinesCatalog medicinesCatalog;
  final dynamic parapharmCatalog;
  final BaseCompany sellerCompany;

  CartItemModel({
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
    required this.medicinesCatalog,
    required this.parapharmCatalog,
    required this.sellerCompany,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      totalAmountTtc: json['totalAmountTtc'],
      totalAmountHt: json['totalAmountHt'],
      tvaPercentage: json['tvaPercentage'],
      unitPriceHt: json['unitPriceHt'],
      unitPriceTtc: json['unitPriceTtc'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      medicinesCatalogId: json['medicinesCatalogId'],
      parapharmCatalogId: json['parapharmCatalogId'],
      quantity: json['quantity'],
      designation: json['designation'],
      lotNumber: json['lotNumber'],
      expirationDate: json['expirationDate'],
      margin: json['margin'],
      discountAmount: json['discountAmount'],
      buyerCompanyId: json['buyerCompanyId'],
      sellerCompanyId: json['sellerCompanyId'],
      medicinesCatalog: MedicinesCatalog.fromJson(json['medicinesCatalog']),
      parapharmCatalog: json['parapharmCatalog'],
      sellerCompany: BaseCompany.fromJson(json['sellerCompany']),
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
      parapharmCatalogId: parapharmCatalogId ?? this.parapharmCatalogId,
      quantity: quantity ?? this.quantity,
      designation: designation ?? this.designation,
      lotNumber: lotNumber ?? this.lotNumber,
      expirationDate: expirationDate ?? this.expirationDate,
      margin: margin ?? this.margin,
      discountAmount: discountAmount ?? this.discountAmount,
      buyerCompanyId: buyerCompanyId ?? this.buyerCompanyId,
      sellerCompanyId: sellerCompanyId ?? this.sellerCompanyId,
      medicinesCatalog: medicinesCatalog ?? this.medicinesCatalog,
      parapharmCatalog: parapharmCatalog ?? this.parapharmCatalog,
      sellerCompany: sellerCompany ?? this.sellerCompany,
    );
  }

  Map<String, num> getTotalPrice() {
    num totalHtPrice = num.parse(totalAmountHt) * quantity;
    num totalTTCPrice = num.parse(totalAmountTtc) * quantity;
    return <String, num>{"totalHtPrice": totalHtPrice, "totalTTCPrice": totalTTCPrice};
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
      stockQuantity: json['stockQuantity'],
    );
  }
}
