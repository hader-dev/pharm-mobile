import 'package:hader_pharm_mobile/utils/urls.dart';

import '../../../config/services/network/network_interface.dart';

import '../../../models/medicine_catalog.dart';
import '../../../models/medicine_catalog_response.dart';
import '../../../utils/constants.dart';
import '../../../utils/enums.dart';
import 'medicine_catalog_repository.dart';

class MedicineCatalogRepository extends IMedicineCatalogRepository {
  final INetworkService client;
  MedicineCatalogRepository({required this.client});

  @override
  Future<MedicineResponse> getMedicinesCatalog(
      {int limit = PaginationConstants.resultsPerPage,
      int offset = 0,
      String sortDirection = 'ASC',
      SearchMedicineFilters? searchFilter,
      String? companyId,
      String search = ''}) async {
    final queryParams = {
      'limit': limit.toString(),
      'offset': offset.toString(),
      'sort[id]': sortDirection,
      if (companyId != null) 'filters[companyId]': companyId.toString(),
      if (searchFilter != null) ...{'search[${searchFilter.name}]': search},
      'computed[isFavorite]': 'true',
      'include[company][fields][]': ['id', 'name', 'thumbnailImage'],
    };
    var decodedResponse = await client.sendRequest(() => client.get(
          Urls.medicinesCatalog,
          queryParams: queryParams,
        ));
    return MedicineResponse.fromJson(decodedResponse);
  }

  @override
  Future<MedicineCatalogModel> getMedicineCatalogById(String id) async {
    var decodedResponse = await client.sendRequest(() => client.get("${Urls.medicinesCatalog}/$id"));
    return MedicineCatalogModel.fromJson(decodedResponse);
  }
}
