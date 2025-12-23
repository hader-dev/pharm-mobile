import 'package:hader_pharm_mobile/models/para_pharma.dart';

import '../../../config/services/network/network_interface.dart';
import '../../../utils/urls.dart';
import 'para_pharm_category_repository.dart';

class ParaPharmCategoryRepository extends IParaPharmCategoryRepository {
  final INetworkService client;
  ParaPharmCategoryRepository({required this.client});

  @override
  Future<List<Category>> getParaPharmCategories({String? searchValue}) async {
    final Map<String, Object> queryParams = {
      if (searchValue != null && searchValue.isNotEmpty) 'search[name]': searchValue,
    };

    var decodedResponse = await client.sendRequest(
      () => client.get(
        Urls.paraPharmCategories,
        queryParams: queryParams,
      ),
    );

    return (decodedResponse["data"] as List).map((brandItem) => Category.fromJson(brandItem)).toList();
  }
}
