import 'package:equatable/equatable.dart' show Equatable;
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/models/gallery.dart' show Gallery;

import 'image.dart';

class BaseParaPharmaCatalogModel {
  final String id;
  final double unitPriceHt;
  final ImageModel? thumbnailImage;
  final ImageModel? image;
  final String name;
  final int stockQuantity;
  final bool isActive;
  final BaseCompany? company;
  bool isLiked;
  final int packageSize;
  final List<String> tags;
  final Category? category;
  final Brand? brand;
  final double unitPriceTtc;
  final double tvaPercentage;
  final int maxOrderQuantity;
  final int minOrderQuantity;
  final int actualQty;
  final int reservedQty;
  final double? computedPrice;

  BaseParaPharmaCatalogModel copyWith(
      {String? id,
      double? unitPriceHt,
      ImageModel? thumbnailImage,
      ImageModel? image,
      String? name,
      int? stockQuantity,
      bool? isActive,
      BaseCompany? company,
      bool? isLiked,
      List<String>? tags,
      double? unitPriceTtc,
      double? tvaPercentage,
      int? packageSize}) {
    return BaseParaPharmaCatalogModel(
      unitPriceTtc: unitPriceTtc ?? this.unitPriceTtc,
      tvaPercentage: tvaPercentage ?? this.tvaPercentage,
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
      brand: brand,
      category: category,
      computedPrice: computedPrice,
    );
  }

  BaseParaPharmaCatalogModel(
      {required this.id,
      required this.tags,
      this.computedPrice,
      required this.packageSize,
      required this.unitPriceHt,
      required this.thumbnailImage,
      required this.image,
      required this.name,
      required this.stockQuantity,
      required this.isActive,
      required this.unitPriceTtc,
      required this.tvaPercentage,
      this.maxOrderQuantity = 9999,
      this.minOrderQuantity = 1,
      this.actualQty = 0,
      this.reservedQty = 0,
      this.category,
      this.brand,
      this.company,
      this.isLiked = false});
}

class BaseBrand extends Equatable {
  final String id;
  final String name;

  const BaseBrand({
    required this.id,
    required this.name,
  });

  factory BaseBrand.fromJson(Map<String, dynamic> json) {
    return BaseBrand(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
    );
  }

  @override
  List<Object?> get props => [id];
}

class Category extends Equatable {
  final String id;
  final String name;

  const Category({
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

  @override
  List<Object?> get props => [id];
}

class ParaPharmaCatalogModel extends BaseParaPharmaCatalogModel {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String companyId;
  final String categoryId;
  final String brandId;
  final String packaging;
  final String sku;
  final String description;
  final Map<String, dynamic>? metaData;
  final Gallery? gallery;

  ParaPharmaCatalogModel({
    required super.id,
    required super.isLiked,
    required super.packageSize,
    super.computedPrice,
    required super.unitPriceHt,
    required super.thumbnailImage,
    required super.image,
    required super.tags,
    required super.name,
    required super.stockQuantity,
    required super.isActive,
    required super.company,
    required super.unitPriceTtc,
    required super.tvaPercentage,
    required this.createdAt,
    required this.updatedAt,
    required this.companyId,
    required this.categoryId,
    required this.brandId,
    required this.packaging,
    required this.sku,
    required this.description,
    required this.metaData,
    required super.minOrderQuantity,
    required super.maxOrderQuantity,
    required super.brand,
    required super.category,
    required this.gallery,
    super.actualQty = 0,
    super.reservedQty = 0,
  });

  factory ParaPharmaCatalogModel.empty() {
    return ParaPharmaCatalogModel(
        id: '',
        name: '',
        unitPriceHt: 0,
        packageSize: 1,
        unitPriceTtc: 0,
        tags: [],
        tvaPercentage: 0,
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
        gallery: null,
        minOrderQuantity: 0,
        maxOrderQuantity: 0);
  }

  @override
  ParaPharmaCatalogModel copyWith({
    String? id,
    double? unitPriceHt,
    ImageModel? thumbnailImage,
    ImageModel? image,
    String? name,
    int? stockQuantity,
    bool? isActive,
    BaseCompany? company,
    bool? isLiked,
    List<String>? tags,
    int? packageSize,
    double? unitPriceTtc,
    double? tvaPercentage,
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
        gallery: gallery,
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

  const Brand({
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
