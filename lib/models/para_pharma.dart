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
  final int packageSize;
  final List<String> tags;

  BaseParaPharmaCatalogModel copyWith(
      {String? id,
      String? unitPriceHt,
      ImageModel? thumbnailImage,
      ImageModel? image,
      String? name,
      int? stockQuantity,
      bool? isActive,
      BaseCompany? company,
      bool? isLiked,
      List<String>? tags,
      int? packageSize}) {
    return BaseParaPharmaCatalogModel(
      tags: tags ?? this.tags,
      packageSize: packageSize ?? this.packageSize,
      id: id ?? this.id,
      unitPriceHt: unitPriceHt ?? this.unitPriceHt,
      thumbnailImage: thumbnailImage ?? this.thumbnailImage,
      image: image ?? this.image,
      name: name ?? this.name,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      isActive: isActive ?? this.isActive,
      company: company ?? this.company,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  BaseParaPharmaCatalogModel(
      {required this.id,
      required this.tags,
      required this.packageSize,
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
      id: json['id'] ?? "",
      name: json['name'] ?? "",
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
      id: json['id'] ?? "",
      name: json['name'] ?? "",
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
    required super.packageSize,
    required super.unitPriceHt,
    required super.thumbnailImage,
    required super.image,
    required super.tags,
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
        unitPriceHt: '0',
        packageSize: 1,
        unitPriceTtc: '0',
        tags: [],
        tvaPercentage: '0',
        thumbnailImage: null,
        image: null,
        stockQuantity: 0,
        isActive: false,
        company: Company.empty(),
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

  ParaPharmaCatalogModel copyWith({
    String? id,
    String? unitPriceHt,
    ImageModel? thumbnailImage,
    ImageModel? image,
    String? name,
    int? stockQuantity,
    bool? isActive,
    BaseCompany? company,
    bool? isLiked,
    List<String>? tags,
    int? packageSize,
    String? unitPriceTtc,
    String? tvaPercentage,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? companyId,
    String? categoryId,
    String? brandId,
    String? packaging,
    String? sku,
    String? description,
    Map<String, dynamic>? metaData,
    int? minOrderQuantity,
    int? maxOrderQuantity,
    Brand? brand,
    Category? category,
  }) {
    return ParaPharmaCatalogModel(
        tags: tags ?? this.tags,
        packageSize: packageSize ?? this.packageSize,
        id: id ?? this.id,
        unitPriceHt: unitPriceHt ?? this.unitPriceHt,
        thumbnailImage: thumbnailImage ?? this.thumbnailImage,
        image: image ?? this.image,
        name: name ?? this.name,
        stockQuantity: stockQuantity ?? this.stockQuantity,
        isActive: isActive ?? this.isActive,
        company: company ?? this.company,
        isLiked: isLiked ?? this.isLiked,
        unitPriceTtc: unitPriceTtc ?? this.unitPriceTtc,
        tvaPercentage: tvaPercentage ?? this.tvaPercentage,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        companyId: companyId ?? this.companyId,
        categoryId: categoryId ?? this.categoryId,
        brandId: brandId ?? this.brandId,
        packaging: packaging ?? this.packaging,
        sku: sku ?? this.sku,
        description: description ?? this.description,
        metaData: metaData ?? this.metaData,
        minOrderQuantity: minOrderQuantity ?? this.minOrderQuantity,
        maxOrderQuantity: maxOrderQuantity ?? this.maxOrderQuantity,
        brand: brand ?? this.brand,
        category: category ?? this.category);
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
        thumbnailImage: json["image"],
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
