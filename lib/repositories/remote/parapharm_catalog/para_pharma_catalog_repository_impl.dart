import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/mappers/json_to_parapharma_catalogue_item.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/params/params_load_parapharma.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/response/para_pharma_response.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

import 'para_pharma_catalog_repository.dart';

class ParaPharmaRepository extends IParaPharmaRepository {
  final INetworkService client;
  ParaPharmaRepository({required this.client});

  @override
  Future<ParaPharmaResponse> getParaPharmaCatalog(ParamsLoadParapharma params) async {
    final queryParams = {
      'limit': params.limit.toString(),
      'offset': params.offset.toString(),
      'sort[id]': params.sortDirection,
      'include[company][fields][]': [
        'id',
        'name',
      ],
    };

    if (params.includeFavorites) {
      queryParams['computed[isFavorite]'] = 'true';
    }

    try {
      var decodedResponse =
          await client.sendRequest(() => client.get(Urls.paraPharamaCatalog, queryParams: queryParams));

      return ParaPharmaResponse.fromJson(decodedResponse);
    } catch (e) {
      debugPrint("$e");
      return ParaPharmaResponse(data: [], totalItems: 0);
    }
  }

  @override
  Future<ParaPharmaCatalogModel> getParaPharmaCatalogById(String id) async {
    try {
      return await client
          .sendRequest(() => client.get(
                '${Urls.paraPharamaCatalog}/$id',
                queryParams: {
                  'computed[isFavorite]': 'true',
                },
              ))
          .then((response) {
        return jsonToParapharmaCatalogueItem(response);
      });
    } catch (e, stacktrack) {
      debugPrintStack(stackTrace: stacktrack);
      debugPrint("$e");
      return ParaPharmaCatalogModel.empty();
    }
  }
}
