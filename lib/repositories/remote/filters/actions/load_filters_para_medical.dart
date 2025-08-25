import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/repositories/remote/filters/mappers/json_to_filters_list.dart';
import 'package:hader_pharm_mobile/repositories/remote/filters/params/param_load_para_medical_fitlers.dart';
import 'package:hader_pharm_mobile/repositories/remote/filters/responses/response_load_filter.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<ResponseLoadFilter> loadFiltersParaMedical(
    INetworkService client, ParamLoadParaMedicalFilter param) async {
  try {
    final queryParams = {
      'limit': param.limit.toString(),
      'offset': param.offset.toString(),
      'sortDirection': param.sort,
      'fields[]': [param.key.name],
      if (param.query.isNotEmpty) 'search[${param.key.name}]': param.query
    };

    final res = await client.sendRequest(() => client.get(
          Urls.parapharms,
          queryParams: queryParams,
        ));

    final data = jsonToFilterList(param.key.name, res);

    return ResponseLoadFilter(data: data);
  } catch (e, stackTrace) {
    debugPrintStack(stackTrace: stackTrace);
    debugPrint("$e");
    return ResponseLoadFilter();
  }
}
