import 'package:hader_pharm_mobile/models/image.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/mappers/json_to_company.dart';
import 'package:hader_pharm_mobile/repositories/remote/utility/mappers/dynamic_list_cast.dart';
import 'package:hader_pharm_mobile/utils/helper_func.dart' show calculateProductStockQty;

BaseParaPharmaCatalogModel jsonToBaseParapharm(Map<String, dynamic> json) {
  return BaseParaPharmaCatalogModel(
      id: json['id'] ?? "",
      tags: mapJsonDynamicListToTypedList(json['tags']),
      packageSize: json['packageSize'] ?? 1,
      unitPriceHt: double.parse(json['unitPriceHt'] ?? "0"),
      minOrderQuantity: json["minOrderQuantity"] ?? 1,
      maxOrderQuantity: json["maxOrderQuantity"] ?? 9999,
      thumbnailImage: json["image"] != null ? ImageModel.fromJson(json["image"]) : null,
      image: json["image"] != null ? ImageModel.fromJson(json["image"]) : null,
      name: json['name'] ?? "",
      stockQuantity: calculateProductStockQty(json['actualQuantity'] ?? 0, json['reservedQuantity'] ?? 0),
      isActive: json['isActive'],
      isLiked: json["isFavorite"] ?? false,
      company: json['company'] != null ? jsonToCompany(json['company']) : null,
      category: json['category'] != null ? Category.fromJson(json['category']) : null,
      brand: json['brand'] != null ? Brand.fromJson(json['brand']) : null,
      tvaPercentage: double.parse(json['tvaPercentage'] ?? "0"),
      unitPriceTtc: double.parse(json['unitPriceTtc'] ?? "0"),
      actualQty: json["actualQuantity"],
      reservedQty: json["reservedQuantity"],
      computedPrice: json['computedPrice'] != null ? double.tryParse(json['computedPrice']) : null);
}
