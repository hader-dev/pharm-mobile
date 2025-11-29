import 'package:flutter/foundation.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/medical_filters.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/repositories/remote/medicine_catalog/mappers/json_to_medicine_catalogue_item.dart';
import 'package:hader_pharm_mobile/repositories/remote/medicine_catalog/response/medicine_catalog_response.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

import 'medicine_catalog_repository.dart';

class MedicineCatalogRepository extends IMedicineCatalogRepository {
  final INetworkService client;
  MedicineCatalogRepository({required this.client});

  @override
  Future<MedicineResponse> getMedicinesCatalog(
      {int limit = PaginationConstants.resultsPerPage,
      int offset = 0,
      String sortDirection = 'DESC',
      String? companyId,
      String? searchValue,
      MedicalFilters filters = const MedicalFilters()}) async {
    final queryParams = {
      'limit': limit.toString(),
      'offset': offset.toString(),
      'sort[id]': sortDirection,
      if (searchValue != null && searchValue.isNotEmpty) 'search[dci]': searchValue,
      'computed[isFavorite]': 'true',
      'include[company][fields][]': [
        'id',
        'name',
      ],
    };

    if (filters.dci.isNotEmpty) queryParams['search[dci]'] = filters.dci.first;
    if (filters.code.isNotEmpty) {
      queryParams['search[code]'] = filters.code.first;
    }
    if (filters.dosage.isNotEmpty) {
      queryParams['search[dosage]'] = filters.dosage.first;
    }
    if (filters.form.isNotEmpty) {
      queryParams['search[form]'] = filters.form.first;
    }
    if (filters.status.isNotEmpty) {
      queryParams['search[status]'] = filters.status.first;
    }
    if (filters.registrationDate.isNotEmpty) {
      queryParams['search[registrationDate]'] = filters.registrationDate.first;
    }
    if (filters.country.isNotEmpty) {
      queryParams['search[country]'] = filters.country.first;
    }
    if (filters.patent.isNotEmpty) {
      queryParams['search[patent]'] = filters.patent.first;
    }
    if (filters.brand.isNotEmpty) {
      queryParams['search[brand]'] = filters.brand.first;
    }
    if (filters.condition.isNotEmpty) {
      queryParams['search[condition]'] = filters.condition.first;
    }
    if (filters.type.isNotEmpty) {
      queryParams['search[type]'] = filters.type.first;
    }
    if (filters.stabilityDuration.isNotEmpty) {
      queryParams['search[stabilityDuration]'] = filters.stabilityDuration.first;
    }
    if (filters.packagingFormat.isNotEmpty) {
      queryParams['search[packagingFormat]'] = filters.packagingFormat.first;
    }
    if (filters.reimbursement.isNotEmpty) {
      queryParams['search[reimbursement]'] = filters.reimbursement.first;
    }
    if (filters.sku.isNotEmpty) {
      queryParams['search[sku]'] = filters.sku.first;
    }
    if (filters.gteUnitPriceHt != null && filters.gteUnitPriceHt!.isNotEmpty) {
      queryParams['gte[unitPriceHt]'] = filters.gteUnitPriceHt!;
    }
    if (filters.lteUnitPriceHt != null && filters.lteUnitPriceHt!.isNotEmpty) {
      queryParams['lte[unitPriceHt]'] = filters.lteUnitPriceHt!;
    }

    if (filters.vendors.isNotEmpty) {
      queryParams['filters[companyId]'] = filters.vendors.first;
    }

    try {
      var decodedResponse = await client.sendRequest(() => client.get(
            Urls.medicinesCatalog,
            queryParams: queryParams,
          ));

      return MedicineResponse.fromJson(decodedResponse);
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      debugPrint("Error fetching medicines: $e");

      return MedicineResponse(data: [], totalItems: 0);
    }
  }

  @override
  Future<MedicineCatalogModel> getMedicineCatalogById(String id) async {
    try {
      var decodedResponse = await client.sendRequest(() => client.get("${Urls.medicinesCatalog}/$id", queryParams: {
            'computed[isFavorite]': 'true',
          }));
      return jsonToMedicineCatalogItem(decodedResponse);
    } catch (e) {
      return MedicineCatalogModel.empty();
    }
  }
}
