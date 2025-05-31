import '../config/services/network/network_manager.dart';

class Product {
  int id;
  int syncId;
  String createdAt;
  String updatedAt;
  String code;
  String imgPath;
  String ref;
  String label;
  String label2;
  String note;
  String description;
  double minPrice;
  double maxPrice;
  bool isOutStock;
  bool isExpired;
  bool isMultiArticle;
  bool isActive;
  int brandId;
  int categoryId;
  int familyId;

  Product({
    required this.id,
    required this.syncId,
    required this.createdAt,
    required this.updatedAt,
    required this.code,
    required this.imgPath,
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
    required this.brandId,
    required this.categoryId,
    required this.familyId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"] ?? 0,
      syncId: json["syncId"] ?? 0,
      createdAt: json["createdAt"] ?? '',
      updatedAt: json["updatedAt"] ?? '',
      code: json["code"] ?? '',
      imgPath: NetworkManager.instance.getImagePath(json["defaultImgPath"]),
      ref: json["ref"] ?? '',
      label: json["label"] ?? '',
      label2: json["label2"] ?? '',
      note: json["note"] ?? '',
      description: json["description"] ?? '',
      minPrice: double.tryParse(json["minPrice"]?.toString() ?? '0') ?? 0,
      maxPrice: double.tryParse(json["maxPrice"]?.toString() ?? '0') ?? 0,
      isOutStock: json["isOutStock"] ?? false,
      isExpired: json["isExpired"] ?? false,
      isMultiArticle: json["isMultiArticle"] ?? false,
      isActive: json["isActive"] ?? false,
      brandId: json["brandId"] ?? 0,
      categoryId: json["categoryId"] ?? 0,
      familyId: json["familyId"] ?? 0,
    );
  }
}
