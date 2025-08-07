import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/medical_filters.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog_response.dart';
import 'package:hader_pharm_mobile/repositories/remote/medicine_catalog/mappers/json_to_medicine_catalogue_item.dart';
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
      String sortDirection = 'ASC',
      MedicalFilters filters = const MedicalFilters()}) async {

    final queryParams = {
      'limit': limit.toString(),
      'offset': offset.toString(),
      'sort[id]': sortDirection,
      'computed[isFavorite]': 'true',
      'include[company][fields][]': ['id', 'name', 'thumbnailImage'],
    };

    if (filters.dci.isNotEmpty) queryParams['search[dci]'] = filters.dci.first;
    if (filters.code.isNotEmpty) queryParams['search[code]'] = filters.code.first;
    if (filters.dosage.isNotEmpty) queryParams['search[dosage]'] = filters.dosage.first;
    if (filters.form.isNotEmpty) queryParams['search[form]'] = filters.form.first;
    if (filters.status.isNotEmpty) queryParams['search[status]'] = filters.status.first;
    if (filters.registrationDate.isNotEmpty) queryParams['search[registrationDate]'] = filters.registrationDate.first;
    if (filters.country.isNotEmpty) queryParams['search[country]'] = filters.country.first;
    if (filters.patent.isNotEmpty) queryParams['search[patent]'] = filters.patent.first;
    if (filters.brand.isNotEmpty) queryParams['search[brand]'] = filters.brand.first;
    if (filters.condition.isNotEmpty) queryParams['search[condition]'] = filters.condition.first;
    if (filters.type.isNotEmpty) queryParams['search[type]'] = filters.type.first;
    if (filters.stabilityDuration.isNotEmpty) queryParams['search[stabilityDuration]'] = filters.stabilityDuration.first;
    if (filters.packagingFormat.isNotEmpty) queryParams['search[packagingFormat]'] = filters.packagingFormat.first;
    if (filters.reimbursement.isNotEmpty) queryParams['search[reimbursement]'] = filters.reimbursement.first;
    if (filters.distributorSku.isNotEmpty) queryParams['search[distributorSku]'] = filters.distributorSku.first;

    var decodedResponse = await client.sendRequest(() => client.get(
          Urls.medicinesCatalog,
          queryParams: queryParams,
        ));
    return MedicineResponse.fromJson(decodedResponse);
  }

  @override

  Future<MedicineCatalogModel> getMedicineCatalogById(String id) async {
    var decodedResponse = await client
        .sendRequest(() => client.get("${Urls.medicinesCatalog}/$id", queryParams: {
          'computed[isFavorite]': 'true',
        }));
    return jsonToMedicineCatalogItem(decodedResponse);
  }
}
