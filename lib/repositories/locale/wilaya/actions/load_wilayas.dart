import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/mappers/json_to_load_wilaya_response.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/params/load_wilayas_params.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/responses/load_wilayas_response.dart';

Future<ResponseLoadWilayas> loadFilters(ParamsLoadWilayas params) async {
  try {
    final jsonLoader = params.jsonStringLoader ?? rootBundle.loadString;

    final String jsonString =
        await jsonLoader('${params.rootPath}/wilaya_${params.locale}.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);


    return jsonToLoadWilayasResponse(jsonMap);
  } catch (e, stack) {
    debugPrint("[loadWilayas] Failed to load wilayas: $e");
    debugPrintStack(stackTrace: stack);
    return ResponseLoadWilayas(wilayas: []);
  }
}
