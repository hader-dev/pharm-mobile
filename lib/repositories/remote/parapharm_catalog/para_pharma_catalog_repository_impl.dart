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
  Future<ParaPharmaResponse> getParaPharmaCatalog(
      ParamsLoadParapharma params) async {
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

    if (params.filters.code.isNotEmpty) {
      queryParams['search[code]'] = params.filters.code.first;
    }
    if (params.filters.dosage.isNotEmpty) {
      queryParams['search[dosage]'] = params.filters.dosage.first;
    }
    if (params.filters.status.isNotEmpty) {
      queryParams['search[status]'] = params.filters.status.first;
    }
    if (params.filters.country.isNotEmpty) {
      queryParams['search[country]'] = params.filters.country.first;
    }
    if (params.filters.patent.isNotEmpty) {
      queryParams['search[patent]'] = params.filters.patent.first;
    }
    if (params.filters.brand.isNotEmpty) {
      queryParams['search[brand]'] = params.filters.brand.first;
    }
    if (params.filters.condition.isNotEmpty) {
      queryParams['search[condition]'] = params.filters.condition.first;
    }
    if (params.filters.type.isNotEmpty) {
      queryParams['search[type]'] = params.filters.type.first;
    }
    if (params.filters.stabilityDuration.isNotEmpty) {
      queryParams['search[stabilityDuration]'] =
          params.filters.stabilityDuration.first;
    }
    if (params.filters.reimbursement.isNotEmpty) {
      queryParams['search[reimbursement]'] = params.filters.reimbursement.first;
    }
    if (params.filters.sku.isNotEmpty) {
      queryParams['search[sku]'] = params.filters.sku.first;
    }

    if (params.filters.name.isNotEmpty) {
      queryParams['search[name]'] = params.filters.name.first;
    }

    if (params.filters.vendors.isNotEmpty) {
      queryParams['filters[companyId]'] = params.filters.vendors.first;
    }

    if ((params.buyerCompanyId != null) && params.buyerCompanyId!.isNotEmpty) {
      queryParams['deligateBuyerCompany[buyerCompanyId]'] =
          params.buyerCompanyId!;
    }

    if (params.searchQuery != null && params.searchQuery!.isNotEmpty) {
      queryParams['search[name]'] = params.searchQuery!;
    }

    if (params.filters.gteUnitPriceHt != null &&
        params.filters.gteUnitPriceHt!.isNotEmpty) {
      queryParams['gte[unitPriceHt]'] = params.filters.gteUnitPriceHt!;
    }
    if (params.filters.lteUnitPriceHt != null &&
        params.filters.lteUnitPriceHt!.isNotEmpty) {
      queryParams['lte[unitPriceHt]'] = params.filters.lteUnitPriceHt!;
    }

    try {
      var decodedResponse = await client.sendRequest(
          () => client.get(Urls.paraPharamaCatalog, queryParams: queryParams));

      return ParaPharmaResponse.fromJson(decodedResponse);
    } catch (e) {
      debugPrint("$e");
      return ParaPharmaResponse(data: [], totalItems: 0);
    }
  }

  @override
  Future<ParaPharmaCatalogModel> getParaPharmaCatalogById(String id,
      [String? buyerCompanyId]) async {
    try {
      final queryParams = {
        'computed[isFavorite]': 'true',
      };

      if (buyerCompanyId != null) {
        queryParams['deligateBuyerCompany[buyerCompanyId]'] = buyerCompanyId;
      }

      return await client
          .sendRequest(() => client.get(
                '${Urls.paraPharamaCatalog}/$id',
                queryParams: queryParams,
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
