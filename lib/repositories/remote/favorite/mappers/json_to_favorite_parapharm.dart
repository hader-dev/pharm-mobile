import 'package:hader_pharm_mobile/models/image.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/mappers/json_to_company.dart';
import 'package:hader_pharm_mobile/repositories/remote/utility/mappers/dynamic_list_cast.dart';
import 'package:hader_pharm_mobile/utils/helper_func.dart'
    show calculateProductStockQty;

BaseParaPharmaCatalogModel jsonToFavoriteBaseParapharm(
    Map<String, dynamic> base) {
  Map<String, dynamic> json = base["parapharmCatalog"];
  Map<String, dynamic>? companyJson = base["company"];

  return BaseParaPharmaCatalogModel(
    id: json['id'],
    tags: mapJsonDynamicListToTypedList(json['tags']),
    packageSize: json['packageSize'] ?? 1,
    unitPriceHt: double.parse(json["unitPriceHt"] ?? "0"),
    thumbnailImage:
        json["image"] != null ? ImageModel.fromJson(json["image"]) : null,
    image: json["image"] != null ? ImageModel.fromJson(json["image"]) : null,
    name: json['name'] ?? "",
    stockQuantity: calculateProductStockQty(
        json['actualQuantity'] ?? 0, json['reservedQuantity'] ?? 0),
    isActive: json['isActive'],
    isLiked: true,
    company: companyJson != null ? jsonToCompany(companyJson) : null,
    unitPriceTtc: double.parse(json["unitPriceTtc"] ?? "0"),
    tvaPercentage: double.parse(json["tvaPercentage"] ?? "0"),
  );
}
