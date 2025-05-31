import '../config/services/network/network_manager.dart';

class BaseCategoryModel {
  int id;
  dynamic imgPath;
  String label;
  int? parentId;

  BaseCategoryModel({
    required this.id,
    required this.imgPath,
    required this.label,
    this.parentId,
  });

  factory BaseCategoryModel.fromJson(Map<String, dynamic> json) => BaseCategoryModel(
        id: json['category_id'],
        imgPath: NetworkManager.instance.getImagePath(json['imgPath']),
        label: json['label'],
        parentId: json['parentId'],
      );
}
