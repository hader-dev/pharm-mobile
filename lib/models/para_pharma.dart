import 'package:hader_pharm_mobile/models/company.dart';

import 'image.dart';

class BaseParaPharmaCatalogModel {
  final String id;
  final String unitPriceHt;
  final ImageModel? thumbnailImage;
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
}

class BaseBrand {
  final String id;
  final String name;

  BaseBrand({
    required this.id,
    required this.name,
  });

  factory BaseBrand.fromJson(Map<String, dynamic> json) {
    return BaseBrand(
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

  factory Category.empty() {
    return Category(
      id: '',
      name: '',
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
    required super.isLiked,
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

  factory ParaPharmaCatalogModel.empty() {
    return ParaPharmaCatalogModel(
        id: '',
        name: '',
        unitPriceHt: '',
        unitPriceTtc: '',
        tvaPercentage: '',
        thumbnailImage: null,
        image: null,
        stockQuantity: 0,
        isActive: false,
        company: null,
        brand: Brand.empty(),
        category: Category.empty(),
        isLiked: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        companyId: '',
        categoryId: '',
        brandId: '',
        packaging: '',
        sku: '',
        description: '',
        metaData: {},
        minOrderQuantity: 0,
        maxOrderQuantity: 0);
  }
}

class Brand extends BaseBrand {
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic thumbnailImage;
  final dynamic image;
  final String companyId;
  final dynamic parentId;

  Brand({
    required super.id,
    required super.name,
    required this.createdAt,
    required this.updatedAt,
    required this.thumbnailImage,
    required this.image,
    required this.companyId,
    required this.parentId,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        thumbnailImage: json["thumbnailImage"],
        image: json["image"],
        companyId: json["companyId"],
        name: json["name"],
        parentId: json["parentId"],
      );

  factory Brand.empty() {
    return Brand(
      id: '',
      name: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      thumbnailImage: '',
      image: '',
      companyId: '',
      parentId: '',
    );
  }
}
