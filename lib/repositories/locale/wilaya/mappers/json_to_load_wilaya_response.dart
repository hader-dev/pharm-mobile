import 'package:hader_pharm_mobile/models/wilaya.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/responses/load_wilayas_response.dart';

ResponseLoadWilayas jsonToLoadWilayasResponse(Map<String, dynamic> json) {
  final data = json['data'];

  if (data is List) {
    final wilayas =
        data.map((e) => Wilaya.fromJson(e as Map<String, dynamic>)).toList();
    return ResponseLoadWilayas(wilayas: wilayas);
  }

  return ResponseLoadWilayas(wilayas: []);
}
