import 'package:hader_pharm_mobile/utils/urls.dart';

import '../../../config/services/network/network_interface.dart';

import '../../../models/medicine_catalog.dart';
import '../../../models/medicine_catalog_response.dart';
import '../../../utils/constants.dart';
import 'medicine_catalog_repository.dart';

class MedicineCatalogRepository extends IMedicineCatalogRepository {
  final INetworkService client;
  MedicineCatalogRepository({required this.client});

  @override
  Future<MedicineResponse> getMedicinesCatalog(
      {int limit = PaginationConstants.resultsPerPage, int offset = 0, String sortDirection = 'ASC'}) async {
    final queryParams = {
      'limit': limit,
      'offset': offset,
      'sort[id]': sortDirection,
    };
    var decodedResponse = await client.sendRequest(() => client.get(
          Urls.medicinesCatalog,
          queryParams: queryParams.map((key, value) => MapEntry(key, value.toString())),
        ));
    return MedicineResponse.fromJson(decodedResponse);
  }

  @override
  Future<MedicineCatalogModel> getMedicineCatalogById(String id) async {
    var decodedResponse = await client.sendRequest(() => client.get("${Urls.medicinesCatalog}/$id"));
    return MedicineCatalogModel.fromJson(decodedResponse);
  }
}
