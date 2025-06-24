import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

import '../../../config/services/network/network_interface.dart';

import '../../../models/para_pharma_response.dart';
import '../../../utils/constants.dart';
import 'para_pharma_catalog_repository.dart';

class ParaPharmaRepository extends IParaPharmaRepository {
  final INetworkService client;
  ParaPharmaRepository({required this.client});

  @override
  Future<ParaPharmaResponse> getParaPharmaCatalog(
      {int limit = PaginationConstants.resultsPerPage,
      int offset = 0,
      String sortDirection = 'ASC',
      List<String> fields = const []}) async {
    final queryParams = {
      'limit': limit,
      'offset': offset,
      'sort[id]': sortDirection,
      if (fields.isNotEmpty) ...{'fields[]': fields},
    };
    var decodedResponse = await client.sendRequest(() => client.get(
          Urls.paraPharamaCatalog,
          queryParams: queryParams.map((key, value) => MapEntry(key, value.toString())),
        ));
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
