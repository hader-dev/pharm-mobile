import 'package:hader_pharm_mobile/repositories/locale/wilaya/mappers/json_to_load_wilaya_towns_response.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/params/load_wilaya_towns_params.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/responses/load_wilaya_towns_response.dart';

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/foundation.dart';

Future<ResponseLoadWilayaTowns> loadWilayaTowns(
    ParamsLoadWilayaTowns params) async {
  try {
    final jsonLoader = params.jsonStringLoader ?? rootBundle.loadString;
    final String path =
        '${params.rootPath}/town_${params.wilayaId}_${params.locale}.json';
    final String jsonString = await jsonLoader(path);
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    return jsonToLoadTownsResponse(jsonMap);
  } catch (e, stack) {
    debugPrint('[getWilayaTowns] Failed to load towns: $e');
    debugPrintStack(stackTrace: stack);
    return ResponseLoadWilayaTowns(towns: []);
  }
}
