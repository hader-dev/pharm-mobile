import 'package:hader_pharm_mobile/models/company.dart';

import 'image.dart';

class BaseParaPharmaCatalogModel {
  final String id;
  final String unitPriceHt;
  final dynamic thumbnailImage;
  final ImageModel? image;
  final String name;
  final int stockQuantity;
  final bool isActive;
  final BaseCompany? company;
  bool isLiked;

  BaseParaPharmaCatalogModel(
      {required this.id,
      required this.unitPriceHt,
      required this.thumbnailImage,
      required this.image,
      required this.name,
      required this.stockQuantity,
      required this.isActive,
      this.company,
      this.isLiked = false});

  factory BaseParaPharmaCatalogModel.fromJson(Map<String, dynamic> json) {
    return BaseParaPharmaCatalogModel(
      id: json['id'],
      unitPriceHt: json['unitPriceHt'],
      thumbnailImage: json['thumbnailImage'],
      image: json["image"] != null ? ImageModel.fromJson(json["image"]) : null,
      name: json['name'],
      stockQuantity: json['stockQuantity'],
      isActive: json['isActive'],
      isLiked: json["isFavorite"] ?? false,
      company: json['company'] != null ? BaseCompany.fromJson(json['company']) : null,
    );
  }
}

class Brand {
  final String id;
  final String name;

  Brand({
    required this.id,
    required this.name,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Category {
  final String id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}

class ParaPharmaCatalogModel extends BaseParaPharmaCatalogModel {
  final String unitPriceTtc;
  final String tvaPercentage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String companyId;
  final String categoryId;
  final String brandId;
  final String packaging;
  final String sku;
  final String description;
  final Map<String, dynamic>? metaData;
  final int minOrderQuantity;
  final int maxOrderQuantity;
  final Brand brand;
  final Category category;

  ParaPharmaCatalogModel({
    required super.id,
    required super.unitPriceHt,
    required super.thumbnailImage,
    required super.image,
    required super.name,
    required super.stockQuantity,
    required super.isActive,
    required super.company,
    required this.unitPriceTtc,
    required this.tvaPercentage,
    required this.createdAt,
    required this.updatedAt,
    required this.companyId,
    required this.categoryId,
    required this.brandId,
    required this.packaging,
    required this.sku,
    required this.description,
    required this.metaData,
    required this.minOrderQuantity,
    required this.maxOrderQuantity,
    required this.brand,
    required this.category,
  });

  factory ParaPharmaCatalogModel.fromJson(Map<String, dynamic> json) {
    return ParaPharmaCatalogModel(
      id: json['id'],
      unitPriceHt: json['unitPriceHt'],
      unitPriceTtc: json['unitPriceTtc'],
      tvaPercentage: json['tvaPercentage'],
      thumbnailImage: json['thumbnailImage'],
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
      brand: Brand.fromJson(json['brand']),
      category: Category.fromJson(json['category']),
      company: json['company'] == null ? null : BaseCompany.fromJson(json['company']),
    );
  }
}
