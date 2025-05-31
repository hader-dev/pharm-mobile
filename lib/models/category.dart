import '../config/services/network/network_manager.dart';
import 'base_category.dart';

class CategoryModel extends BaseCategoryModel {
  final int? syncId;
  final DateTime createdAt;
  final DateTime updatedAt;
  @override
  final int? parentId;

  CategoryModel({
    required super.id,
    required super.imgPath,
    required super.label,
    this.syncId,
    required this.createdAt,
    required this.updatedAt,
    this.parentId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      imgPath: NetworkManager.instance.getImagePath(json['imgPath']) ?? '',
      label: json['label'] ?? '',
      syncId: json['syncId'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      parentId: json['parentId'] ?? 0,
    );
  }
}
