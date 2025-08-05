import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/para_medical_filters.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/models/para_pharma_response.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';
import 'para_pharma_catalog_repository.dart';

class ParaPharmaRepository extends IParaPharmaRepository {
  final INetworkService client;
  ParaPharmaRepository({required this.client});

  @override
  Future<ParaPharmaResponse> getParaPharmaCatalog(
      {int limit = PaginationConstants.resultsPerPage,
      int offset = 0,
      String sortDirection = 'ASC',
      List<String> fields = const [],
      ParaMedicalFilters filters = const ParaMedicalFilters()
      }) async {

    final queryParams = {
      'limit': limit.toString(),
      'offset': offset.toString(),
      'sort[id]': sortDirection,
      'computed[isFavorite]': 'true',
      'include[company][fields][]': ['id', 'name', 'thumbnailImage'],
    };
    
    if (filters.code.isNotEmpty) queryParams['search[code]'] = filters.code.first;
    if (filters.dosage.isNotEmpty) queryParams['search[dosage]'] = filters.dosage.first;
    if (filters.status.isNotEmpty) queryParams['search[status]'] = filters.status.first;
    if (filters.country.isNotEmpty) queryParams['search[country]'] = filters.country.first;
    if (filters.patent.isNotEmpty) queryParams['search[patent]'] = filters.patent.first;
    if (filters.brand.isNotEmpty) queryParams['search[brand]'] = filters.brand.first;
    if (filters.condition.isNotEmpty) queryParams['search[condition]'] = filters.condition.first;
    if (filters.type.isNotEmpty) queryParams['search[type]'] = filters.type.first;
    if (filters.stabilityDuration.isNotEmpty) queryParams['search[stabilityDuration]'] = filters.stabilityDuration.first;
    if (filters.reimbursement.isNotEmpty) queryParams['search[reimbursement]'] = filters.reimbursement.first;
    if (filters.distributorSku.isNotEmpty) queryParams['search[distributorSku]'] = filters.distributorSku.first;


    var decodedResponse = await client.sendRequest(() => client.get(Urls.paraPharamaCatalog, queryParams: queryParams));
    return ParaPharmaResponse.fromJson(decodedResponse);
  }

  @override
  Future<ParaPharmaCatalogModel> getParaPharmaCatalogById(String id) async {
    return await client
        .sendRequest(() => client.get(
              '${Urls.paraPharamaCatalog}/$id',
            ))
        .then((response) {
      return ParaPharmaCatalogModel.fromJson(response);
    });
  }
}
