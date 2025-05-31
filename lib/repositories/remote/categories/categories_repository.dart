//import '../../../model/person.dart';

import '../../../models/category.dart';

abstract class ICategoriesRepository {
  Future<List<CategoryModel>> getCategories(
      {String? category,
      String? search,
      String? brand,
      int? parentId,
      required int limit,
      required int offset});
}
