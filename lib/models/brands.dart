import '../config/services/network/network_manager.dart';
import 'base_category.dart';

class BrandsModel extends BaseCategoryModel {
  final int? syncId;
  final DateTime createdAt;
  final DateTime updatedAt;
  @override
  final int? parentId;

  BrandsModel({
    required super.id,
    required super.imgPath,
    required super.label,
    this.syncId,
    required this.createdAt,
    required this.updatedAt,
    this.parentId,
  });

  factory BrandsModel.fromJson(Map<String, dynamic> json) {
    return BrandsModel(
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
