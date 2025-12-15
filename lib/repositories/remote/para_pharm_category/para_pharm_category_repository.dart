import 'package:hader_pharm_mobile/models/para_pharma.dart' show Category;

abstract class IParaPharmCategoryRepository {
  Future<List<Category>> getParaPharmCategories({String? searchValue});
}
