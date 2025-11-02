import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/models/image.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';

BaseMedicineCatalogModel jsonToFavoriteBaseMedicine(Map<String, dynamic> base) {
  Map<String, dynamic> jsonMedicine = base["medicineCatalog"];
  Map<String, dynamic>? jsonCompany = base["company"];

  return BaseMedicineCatalogModel(
    packageSize: jsonMedicine["packageSize"] ?? 1,
    id: jsonMedicine["id"] ?? "",
    unitPriceHt: double.parse(jsonMedicine["unitPriceHt"] ?? "0"),
    unitPriceTtc: double.parse(jsonMedicine["unitPriceTtc"] ?? "0"),
    tvaPercentage: double.parse(jsonMedicine["tvaPercentage"] ?? "0"),
    thumbnailImage: jsonMedicine["thumbnailImage"],
    image: jsonMedicine["image"] != null
        ? ImageModel.fromJson(jsonMedicine["image"])
        : null,
    createdAt: DateTime.parse(jsonMedicine["createdAt"]),
    updatedAt: DateTime.parse(jsonMedicine["updatedAt"]),
    companyId: jsonMedicine["companyId"] ?? "",
    dci: jsonMedicine["dci"],
    registrationNumber: jsonMedicine["registrationNumber"] ?? "",
    sku: jsonMedicine["sku"] ?? "",
    isPrivate: jsonMedicine["isPrivate"] ?? false,
    margin: jsonMedicine["margin"] ?? "",
    stockQuantity: jsonMedicine["stockQuantity"] ?? 0,
    minOrderQuantity: jsonMedicine["minOrderQuantity"] ?? 0,
    maxOrderQuantity: jsonMedicine["maxOrderQuantity"] ?? 0,
    isPsychoactive: jsonMedicine["isPsychoactive"] ?? false,
    requiresColdChain: jsonMedicine["requiresColdChain"] ?? false,
    isActive: jsonMedicine["isActive"] ?? false,
    isQuota: jsonMedicine["isQuota"] ?? false,
    isFeatured: jsonMedicine["isFeatured"] ?? false,
    displayOrder: jsonMedicine["displayOrder"] ?? 0,
    isLiked: jsonMedicine["isFavorite"] ?? false,
    company: jsonCompany != null ? BaseCompany.fromJson(jsonCompany) : null,
  );
}
