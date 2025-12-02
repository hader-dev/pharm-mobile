import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/models/gallery.dart' show Gallery;
import 'package:hader_pharm_mobile/models/image.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/mappers/json_to_company.dart';
import 'package:hader_pharm_mobile/repositories/remote/utility/mappers/dynamic_list_cast.dart';
import 'package:hader_pharm_mobile/utils/helper_func.dart' show calculateProductStockQty;

ParaPharmaCatalogModel jsonToParapharmaCatalogueItem(Map<String, dynamic> json) {
  int minOrderQty = json["minOrderQuantity"] ?? 1;
  minOrderQty = minOrderQty == 0 ? 1 : minOrderQty;

  int maxOrderQty = json["maxOrderQuantity"] ?? 9999;
  maxOrderQty = maxOrderQty == 0 ? 9999 : maxOrderQty;
  return ParaPharmaCatalogModel(
    id: json['id'] ?? "",
    tags: mapJsonDynamicListToTypedList(json['tags']),
    packageSize: json['packageSize'] ?? 1,
    unitPriceTtc: double.parse(json["unitPriceTtc"] ?? "0"),
    tvaPercentage: double.parse(json["tvaPercentage"] ?? "0"),
    unitPriceHt: double.parse(json['unitPriceHt'] ?? "0.0"),
    thumbnailImage: json["image"] != null ? ImageModel.fromJson(json["image"]) : null,
    image: json["image"] != null ? ImageModel.fromJson(json["image"]) : null,
    name: json['name'] ?? "",
    stockQuantity: calculateProductStockQty(json['actualQuantity'] ?? 0, json['reservedQuantity'] ?? 0),
    isActive: json['isActive'] ?? false,
    createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) ?? DateTime(1970) : DateTime(1970),
    updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) ?? DateTime(1970) : DateTime(1970),
    companyId: json['companyId'] ?? "",
    categoryId: json['categoryId'] ?? "",
    brandId: json['brandId'] ?? "",
    packaging: json['packaging'] ?? "",
    sku: json['sku'] ?? "",
    description: json['description'] ?? "",
    metaData: json['metaData'] ?? {},
    minOrderQuantity: minOrderQty,
    maxOrderQuantity: maxOrderQty,
    brand: json['brand'] == null ? Brand.empty() : Brand.fromJson(json['brand']),
    category: json['category'] == null ? Category.empty() : Category.fromJson(json['category']),
    isLiked: json["isFavorite"] ?? false,
    company: json['company'] == null ? Company.empty() : jsonToCompany(json['company']),
    computedPrice: json['computedPrice'] != null ? double.tryParse(json['computedPrice']) : null,
    gallery: json['gallery'] == null ? null : Gallery.fromJson(json['gallery']),
  );
}
