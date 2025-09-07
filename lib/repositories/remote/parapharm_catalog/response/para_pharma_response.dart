import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/mappers/json_to_base_parapharm.dart';

class ParaPharmaResponse {
  final int totalItems;
  final List<BaseParaPharmaCatalogModel> data;

  ParaPharmaResponse({required this.totalItems, required this.data});

  factory ParaPharmaResponse.fromJson(Map<String, dynamic> json) {
    return ParaPharmaResponse(
      totalItems: json["totalItems"] ?? 0,
      data: (json["data"] as List).map((e) => jsonToBaseParapharm(e)).toList(),
    );
  }
}
