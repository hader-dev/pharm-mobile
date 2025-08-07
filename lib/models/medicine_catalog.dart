import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/models/image.dart';
import 'package:hader_pharm_mobile/models/medicine.dart';

class BaseMedicineCatalogModel {
  final String id;
  final String unitPriceTtc;
  final String unitPriceHt;
  final String tvaPercentage;
  final dynamic thumbnailImage;
  final ImageModel? image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String companyId;
  final dynamic dci;
  final String registrationNumber;
  final String distributorSku;
  final bool isPrivate;
  final String margin;
  final int stockQuantity;
  final int minOrderQuantity;
  final int maxOrderQuantity;
  final bool isPsychoactive;
  final bool requiresColdChain;
  final bool isActive;
  final bool isQuota;
  final bool isFeatured;
  final int displayOrder;
  final BaseCompany? company;
  bool isLiked;

  BaseMedicineCatalogModel({
    required this.id,
    required this.unitPriceTtc,
    required this.unitPriceHt,
    required this.tvaPercentage,
    required this.thumbnailImage,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.companyId,
    required this.dci,
    required this.registrationNumber,
    required this.distributorSku,
    required this.isPrivate,
    required this.margin,
    required this.stockQuantity,
    required this.minOrderQuantity,
    required this.maxOrderQuantity,
    required this.isPsychoactive,
    required this.requiresColdChain,
    required this.isActive,
    required this.isQuota,
    required this.isFeatured,
    required this.displayOrder,
    required this.company,
    this.isLiked = false,
  });

  factory BaseMedicineCatalogModel.fromJson(Map<String, dynamic> json) {
    return BaseMedicineCatalogModel(
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
      distributorSku: json["distributorSku"] ?? "",
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
      displayOrder: json["displayOrder"] ?? 0,
      isLiked: json["isFavorite"] ?? false,
      company: json["company"] != null ? BaseCompany.fromJson(json["company"]) : null,
    );
  }
}

class MedicineCatalogModel extends BaseMedicineCatalogModel {
  @override
  // ignore: overridden_fields
  final Company company;

  final Medicine medicine;

  MedicineCatalogModel({
    required super.id,
    required super.unitPriceTtc,
    required super.unitPriceHt,
    required super.tvaPercentage,
    required super.thumbnailImage,
    required super.image,
    required super.createdAt,
    required super.updatedAt,
    required super.companyId,
    required super.dci,
    required super.registrationNumber,
    required super.distributorSku,
    required super.isPrivate,
    required super.margin,
    required super.stockQuantity,
    required super.minOrderQuantity,
    required super.maxOrderQuantity,
    required super.isPsychoactive,
    required super.requiresColdChain,
    required super.isActive,
    required super.isQuota,
    required super.isFeatured,
    required super.displayOrder,
    required this.company,
    required this.medicine,
  }) : super(
          company: company,
        );

}
