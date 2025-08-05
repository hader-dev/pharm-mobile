import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hader_pharm_mobile/models/para_medical_filters.dart';
import 'package:hader_pharm_mobile/repositories/locale/filters/mappers/json_to_load_filters_para_medical_response.dart';
import 'package:hader_pharm_mobile/repositories/locale/filters/params/params_load_filters.dart';
import 'package:hader_pharm_mobile/repositories/locale/filters/responses/response_load_filters_para_medical.dart';

Future<ResponseLoadFiltersParaMedical> loadFiltersParaMedical(
    ParamsLoadFiltersParaMedical params) async {
  try {
    final jsonLoader = params.jsonStringLoader ?? rootBundle.loadString;
    final Map<String, dynamic> jsonMap = {};

    for (final filterItem in params.filterItems) {
      final fileName = '${filterItem.name}.json';
      final jsonString =
          await jsonLoader('${params.rootPath}/$fileName');
      jsonMap[filterItem.name] = json.decode(jsonString)["data"];
    }

    return jsonToLoadFiltersParaMedicalResponse(jsonMap);
  } catch (e, stack) {
    debugPrint("[loadParaMedicalFilters] Failed to load para-pharma filters: $e");
    debugPrintStack(stackTrace: stack);
    return ResponseLoadFiltersParaMedical(filters: const ParaMedicalFilters());
  }
}
