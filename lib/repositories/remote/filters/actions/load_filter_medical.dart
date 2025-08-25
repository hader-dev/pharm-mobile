import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/medical_filters.dart';
import 'package:hader_pharm_mobile/repositories/remote/filters/mappers/json_to_filters_list.dart';
import 'package:hader_pharm_mobile/repositories/remote/filters/params/params_load_medical_filters.dart';
import 'package:hader_pharm_mobile/repositories/remote/filters/responses/response_load_filter.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<ResponseLoadFilter> loadMedicalFilter(
    INetworkService client, ParamLoadMedicalFilter param) async {
  try {
    final queryParams = {
      'limit': param.limit.toString(),
      'offset': param.offset.toString(),
      'sortDirection': param.sort,
      'fields[]': [param.key.name],
      if (param.query.isNotEmpty) 'search[${param.key.name}]': param.query
    };

    final isCatalogKey = param.key == MedicalFiltersKeys.distributorSku;
    final url = isCatalogKey ? Urls.medicinesCatalog : Urls.medicines;

    final res = await client.sendRequest(() => client.get(
          url,
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
