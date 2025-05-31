import '../../../config/services/network/network_manager.dart';
import '../../../config/services/network/network_response_handler.dart';
import '../../../models/brands.dart';
import '../../../utils/urls.dart';
import 'brands_repository.dart';

class BrandsRepository extends IBrandsRepository {
  @override
  Future<List<BrandsModel>> getBrands(
      {String? category,
      String? search,
      String? brand,
      int? parentId,
      int? limit,
      int? offset}) async {
    final queryParams = {
      ...{if (offset != null) 'offset': offset.toString()},
      ...{if (limit != null) 'limit': limit.toString()},
      'in[parentId][]': parentId.toString(),
      'sortDirection': 'DESC',
    };

    if (search != null && search.isNotEmpty) {
      queryParams['search[label]'] = search;
    }

    final response = await NetworkManager.instance
        .sendRequest(() => NetworkManager.instance.get(
              Urls.brands,
              queryParams: queryParams,
            ));
    var decodedResponse = ResponseHandler.processResponse(response);
    List<BrandsModel> categorys = (decodedResponse["data"] as List)
        .map((item) => BrandsModel.fromJson(item))
        .toList();
    return categorys;
  }
}
