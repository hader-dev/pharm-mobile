import '../../../../models/medicine_catalog.dart';

class MedicineResponse {
  final int totalItems;
  final List<BaseMedicineCatalogModel> data;

  MedicineResponse({required this.totalItems, required this.data});

  factory MedicineResponse.fromJson(Map<String, dynamic> json) {
    return MedicineResponse(
      totalItems: json["totalItems"] ?? 0,
      data: (json["data"] as List).map((e) => BaseMedicineCatalogModel.fromJson(e)).toList(),
    );
  }
}
