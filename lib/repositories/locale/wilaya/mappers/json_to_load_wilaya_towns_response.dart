import 'package:hader_pharm_mobile/models/wilaya.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/responses/load_wilaya_towns_response.dart';

ResponseLoadWilayaTowns jsonToLoadTownsResponse(Map<String, dynamic> json) {
  final data = json['data'];
  if (data is List) {
    final towns =
        data.map((e) => Town.fromJson(e as Map<String, dynamic>)).toList();
    return ResponseLoadWilayaTowns(towns: towns);
  }

  return ResponseLoadWilayaTowns(towns: []);
}
