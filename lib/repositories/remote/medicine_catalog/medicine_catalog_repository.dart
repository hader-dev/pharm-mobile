import '../../../models/medicine_catalog.dart';
import '../../../models/medicine_catalog_response.dart';
import '../../../utils/enums.dart';

abstract class IMedicineCatalogRepository {
  Future<MedicineResponse> getMedicinesCatalog(
      {int limit = 8,
      int offset = 0,
      String sortDirection = 'ASC',
      SearchMedicineFilters? searchFilter,
      String? companyId,
      String search = ''});
  Future<MedicineCatalogModel> getMedicineCatalogById(String id);
}
