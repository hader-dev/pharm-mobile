import 'package:hader_pharm_mobile/models/image.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/mappers/json_to_company.dart';

ParaPharmaCatalogModel jsonToParapharmaCatalogueItem(
    Map<String, dynamic> json) {
  return ParaPharmaCatalogModel(
    id: json['id'],
    unitPriceHt: json['unitPriceHt'],
    unitPriceTtc: json['unitPriceTtc'],
    tvaPercentage: json['tvaPercentage'],
    thumbnailImage:
        json["image"] != null ? ImageModel.fromJson(json["image"]) : null,
    image: json["image"] != null ? ImageModel.fromJson(json["image"]) : null,
    name: json['name'],
    stockQuantity: json['stockQuantity'],
    isActive: json['isActive'],
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: DateTime.parse(json['updatedAt']),
    companyId: json['companyId'],
    categoryId: json['categoryId'],
    brandId: json['brandId'],
    packaging: json['packaging'],
    sku: json['sku'],
    description: json['description'],
    metaData: json['metaData'],
    minOrderQuantity: json['minOrderQuantity'],
    maxOrderQuantity: json['maxOrderQuantity'],
    brand:
        json['brand'] == null ? Brand.empty() : Brand.fromJson(json['brand']),
    category: json['category'] == null
        ? Category.empty()
        : Category.fromJson(json['category']),
    isLiked: json["isFavorite"] ?? false,
    company: json['company'] == null ? null : jsonToCompany(json['company']),
  );
}
