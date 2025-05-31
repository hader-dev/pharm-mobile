import 'package:equatable/equatable.dart';

import '../config/services/network/network_manager.dart';
import 'create_cart_item.dart';

class ProductDetailsModel {
  final int id;
  final int? syncId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String code;
  final String defaultImgPath;
  final String ref;
  final String label;
  final String label2;
  final String note;
  final String description;
  final String minPrice;
  final String maxPrice;
  final bool isOutStock;
  final bool isExpired;
  final bool isMultiArticle;
  final bool isActive;
  final int? brandId;
  final int? categoryId;
  final List<ArticleGallery> gallery;
  final List<Article> articles;

  ProductDetailsModel({
    required this.id,
    this.syncId,
    required this.createdAt,
    required this.updatedAt,
    required this.code,
    required this.defaultImgPath,
    required this.ref,
    required this.label,
    required this.label2,
    required this.note,
    required this.description,
    required this.minPrice,
    required this.maxPrice,
    required this.isOutStock,
    required this.isExpired,
    required this.isMultiArticle,
    required this.isActive,
    this.brandId,
    this.categoryId,
    required this.gallery,
    required this.articles,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['id'],
      syncId: json['syncId'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      code: json['code'],
      defaultImgPath: json['defaultImgPath'],
      ref: json['ref'],
      label: json['label'],
      label2: json['label2'],
      note: json['note'],
      description: json['description'],
      minPrice: json['minPrice'],
      maxPrice: json['maxPrice'],
      isOutStock: json['isOutStock'],
      isExpired: json['isExpired'],
      isMultiArticle: json['isMultiArticle'],
      isActive: json['isActive'],
      brandId: json['brandId'] ?? 0,
      categoryId: json['categoryId'] ?? 0,
      gallery: (json['gallery'] as List)
          .map((item) => ArticleGallery.fromJson(item))
          .toList(),
      articles: (json['articles'] as List)
          .map((item) => Article.fromJson(item))
          .toList(),
    );
  }
}

class ArticleGallery {
  final int id;
  final String path;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int productId;

  ArticleGallery({
    required this.id,
    required this.path,
    required this.createdAt,
    required this.updatedAt,
    required this.productId,
  });

  factory ArticleGallery.fromJson(Map<String, dynamic> json) {
    return ArticleGallery(
      id: json['id'],
      path: NetworkManager.instance.getImagePath(
        json['path'],
      ),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      productId: json['productId'],
    );
  }
}

class BaseArticle {
  final int id;
  final String label;
  final String? imgPath;

  BaseArticle({
    required this.id,
    required this.label,
    this.imgPath,
  });

  factory BaseArticle.fromJson(Map<String, dynamic> json) {
    return BaseArticle(
        id: json['id'], label: json['label'], imgPath: json['imgPath']);
  }
}

class Article extends BaseArticle with EquatableMixin {
  final int? syncId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final String? ref;
  final String? note;
  final int? tvaPercentage;
  final String? description;
  final String? price;
  final bool? isActive;
  final int? productId;
  final List<OptionValue>? optionValues;

  Article({
    required super.id,
    this.syncId,
    this.createdAt,
    this.updatedAt,
    required super.label,
    super.imgPath,
    this.ref,
    this.note,
    this.tvaPercentage,
    this.description,
    this.price,
    this.isActive,
    this.productId,
    this.optionValues,
  });

  @override
  List<Object?> get props => <Object?>[id];

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      syncId: json['syncId'],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      label: json['label'] ?? "",
      imgPath: NetworkManager.instance.getImagePath(json['imgPath']) ?? "",
      ref: json['ref'] ?? "",
      note: json['note'] ?? "",
      tvaPercentage: json['tvaPercentage'] ?? 0,
      description: json['description'] ?? "",
      price: json['price'] ?? "",
      isActive: json['isActive'] ?? false,
      productId: json['productId'] ?? 0,
      optionValues: (json['optionValues'] as List?)
              ?.map((item) => OptionValue.fromJson(item))
              .toList() ??
          <OptionValue>[],
    );
  }
  CreateCartItemModel createCartItem(int quantity) {
    return CreateCartItemModel(
      articleId: id,
      quantity: quantity,
    );
  }
}

class BaseOptionValue {
  final int id;
  final String value;

  BaseOptionValue({
    required this.id,
    required this.value,
  });

  factory BaseOptionValue.fromJson(Map<String, dynamic> json) {
    return BaseOptionValue(id: json['id'], value: json['value']);
  }
}

class OptionValue extends BaseOptionValue with EquatableMixin {
  final int? syncId;
  final int optionId;
  final Option option;

  OptionValue({
    required int id,
    this.syncId,
    required String value,
    required this.optionId,
    required this.option,
  }) : super(id: id, value: value);

  @override
  List<Object?> get props => <Object?>[id, syncId, value, optionId, option];

  factory OptionValue.fromJson(Map<String, dynamic> json) {
    return OptionValue(
      id: json['id'],
      syncId: json['syncId'],
      value: json['value'],
      optionId: json['optionId'],
      option: Option.fromJson(json['option']),
    );
  }
}

class Option extends Equatable {
  final int id;
  final String label;
  final dynamic syncId;

  const Option({
    required this.id,
    required this.label,
    this.syncId,
  });

  @override
  List<Object?> get props => <Object?>[id, label];

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      label: json['label'],
      syncId: json['syncId'],
    );
  }
}
