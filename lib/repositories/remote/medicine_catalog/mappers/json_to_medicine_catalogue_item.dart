import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/models/image.dart';
import 'package:hader_pharm_mobile/models/medicine.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/mappers/json_to_company.dart';
import 'package:hader_pharm_mobile/repositories/remote/medicine_catalog/mappers/json_to_medicine.dart';

MedicineCatalogModel jsonToMedicineCatalogItem(Map<String, dynamic> json) {
  return MedicineCatalogModel(
    packageSize: json["packageSize"] ?? 1,
    id: json["id"] ?? "",
    unitPriceTtc: json["unitPriceTtc"] ?? "",
    unitPriceHt: json["unitPriceHt"] ?? "",
    tvaPercentage: json["tvaPercentage"] ?? "",
    thumbnailImage: json["thumbnailImage"],
    image: json["image"] != null ? ImageModel.fromJson(json["image"]) : null,
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    companyId: json["companyId"] ?? "",
    dci: json["dci"],
    registrationNumber: json["registrationNumber"] ?? "",
    sku: json["sku"] ?? "",
    isPrivate: json["isPrivate"] ?? false,
    margin: json["margin"] ?? "",
    stockQuantity: json["stockQuantity"] ?? 0,
    minOrderQuantity: json["minOrderQuantity"] ?? 0,
    maxOrderQuantity: json["maxOrderQuantity"] ?? 0,
    isPsychoactive: json["isPsychoactive"] ?? false,
    requiresColdChain: json["requiresColdChain"] ?? false,
    isActive: json["isActive"] ?? false,
    isQuota: json["isQuota"] ?? false,
    isFeatured: json["isFeatured"] ?? false,
    isLiked: json["isFavorite"] ?? false,
    displayOrder: json["displayOrder"] ?? 0,
    company: (json["company"] != null)
        ? jsonToCompany(json["company"])
        : Company.empty(),
    medicine: (json["medicine"] != null)
        ? jsonToMedicine(json["medicine"])
        : Medicine.empty(),
  );
}
