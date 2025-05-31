import '../../../config/services/network/network_manager.dart';
import '../../../config/services/network/network_response_handler.dart';
import '../../../models/category.dart';
import '../../../utils/urls.dart';
import 'categories_repository.dart';

class CategoryRepository extends ICategoriesRepository {
  @override
  Future<List<CategoryModel>> getCategories(
      {String? category, String? search, String? brand, int? parentId, int? limit, int? offset}) async {
    final queryParams = {
      ...{if (offset != null) 'offset': offset.toString()},
      ...{if (limit != null) 'limit': limit.toString()},
      'in[parentId][]': parentId.toString(),
      // ...{if (parentId != null) 'filters[parentId]': parentId.toString()},
      'sortDirection': 'DESC',
    };

    if (search != null && search.isNotEmpty) {
      queryParams['search[label]'] = search;
    }

    final response = await NetworkManager.instance.sendRequest(() => NetworkManager.instance.get(
          Urls.categories,
          queryParams: queryParams,
        ));
    var decodedResponse = ResponseHandler.processResponse(response);
    List<CategoryModel> categorys =
        (decodedResponse["data"] as List).map((item) => CategoryModel.fromJson(item)).toList();
    return categorys;
  }
}
