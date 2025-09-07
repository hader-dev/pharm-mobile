import 'package:hader_pharm_mobile/models/image.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/mappers/json_to_company.dart';

BaseParaPharmaCatalogModel jsonToFavoriteBaseParapharm(
    Map<String, dynamic> base) {
  Map<String, dynamic> json = base["parapharmCatalog"];
  Map<String, dynamic>? companyJson = base["company"];

  return BaseParaPharmaCatalogModel(
    id: json['id'],
    unitPriceHt: json['unitPriceHt'],
    thumbnailImage: json["thumbnailImage"] != null
        ? ImageModel.fromJson(json["thumbnailImage"])
        : null,
    image: json["image"] != null ? ImageModel.fromJson(json["image"]) : null,
    name: json['name'],
    stockQuantity: json['stockQuantity'],
    isActive: json['isActive'],
    isLiked: json["isFavorite"] ?? false,
    company: companyJson != null ? jsonToCompany(companyJson) : null,
  );
}
