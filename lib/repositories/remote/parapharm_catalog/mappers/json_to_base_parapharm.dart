import 'package:hader_pharm_mobile/models/image.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/mappers/json_to_company.dart';

BaseParaPharmaCatalogModel jsonToBaseParapharm(Map<String, dynamic> json) {
  return BaseParaPharmaCatalogModel(
    id: json['id'],
    packageSize: json['packageSize'] ?? 1,
    unitPriceHt: json['unitPriceHt'],
    thumbnailImage: json["thumbnailImage"] != null
        ? ImageModel.fromJson(json["thumbnailImage"])
        : null,
    image: json["image"] != null ? ImageModel.fromJson(json["image"]) : null,
    name: json['name'],
    stockQuantity: json['stockQuantity'],
    isActive: json['isActive'],
    isLiked: json["isFavorite"] ?? false,
    company: json['company'] != null ? jsonToCompany(json['company']) : null,
  );
}
