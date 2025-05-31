//import '../../../model/person.dart';

import '../../../models/brands.dart';

abstract class IBrandsRepository {
  Future<List<BrandsModel>> getBrands(
      {String? category,
      String? search,
      String? brand,
      int? parentId,
      required int limit,
      required int offset});
}
