import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/models/image.dart';
import 'package:hader_pharm_mobile/models/medicine.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/mappers/json_to_company.dart';
import 'package:hader_pharm_mobile/repositories/remote/medicine_catalog/mappers/json_to_medicine.dart';
import 'package:hader_pharm_mobile/utils/helper_func.dart' show calculateProductStockQty;

MedicineCatalogModel jsonToMedicineCatalogItem(Map<String, dynamic> json) {
  int minOrderQty = json["minOrderQuantity"] ?? 1;
  minOrderQty = minOrderQty == 0 ? 1 : minOrderQty;

  int maxOrderQty = json["maxOrderQuantity"] ?? 9999;
  maxOrderQty = maxOrderQty == 0 ? 9999 : maxOrderQty;
  return MedicineCatalogModel(
      packageSize: json["packageSize"] ?? 1,
      id: json["id"] ?? "",
      unitPriceTtc: double.parse(json["unitPriceTtc"] ?? "0"),
      unitPriceHt: double.parse(json["unitPriceHt"] ?? "0"),
      tvaPercentage: double.parse(json["tvaPercentage"] ?? "0"),
      thumbnailImage: json["image"],
      image: json["image"] != null ? ImageModel.fromJson(json["image"]) : null,
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      companyId: json["companyId"] ?? "",
      dci: json["dci"],
      registrationNumber: json["registrationNumber"] ?? "",
      sku: json["sku"] ?? "",
      isPrivate: json["isPrivate"] ?? false,
      margin: json["margin"] ?? "",
      stockQuantity: calculateProductStockQty(json['actualQuantity'] ?? 0, json['reservedQuantity'] ?? 0),
      minOrderQuantity: minOrderQty,
      maxOrderQuantity: maxOrderQty,
      isPsychoactive: json["isPsychoactive"] ?? false,
      requiresColdChain: json["requiresColdChain"] ?? false,
      isActive: json["isActive"] ?? false,
      isQuota: json["isQuota"] ?? false,
      isFeatured: json["isFeatured"] ?? false,
      isLiked: json["isFavorite"] ?? false,
      displayOrder: json["displayOrder"] ?? 0,
      company: (json["company"] != null) ? jsonToCompany(json["company"]) : Company.empty(),
      medicine: (json["medicine"] != null) ? jsonToMedicine(json["medicine"]) : Medicine.empty(),
      computedPrice: json['computedPrice'] != null ? double.tryParse(json['computedPrice']) : null);
}
