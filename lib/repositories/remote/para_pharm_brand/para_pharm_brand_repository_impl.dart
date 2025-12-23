import 'package:hader_pharm_mobile/models/para_pharma.dart';

import '../../../config/services/network/network_interface.dart';

import '../../../utils/urls.dart';
import 'para_pharm_brand_repository.dart';

class ParaPharmBrandRepository extends IParaPharmBrandRepository {
  final INetworkService client;
  ParaPharmBrandRepository({required this.client});

  @override
  Future<List<Brand>> getParaPharmBrands({String? searchValue}) async {
    final Map<String, Object> queryParams = {
      if (searchValue != null && searchValue.isNotEmpty) 'search[name]': searchValue,
    };

    var decodedResponse = await client.sendRequest(
      () => client.get(
        Urls.paraPharmBrands,
        queryParams: queryParams,
      ),
    );

    return (decodedResponse["data"] as List).map((brandItem) => Brand.fromJson(brandItem)).toList();
  }
}
