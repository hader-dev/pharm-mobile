import '../../../models/medicine_catalog.dart';
import '../../../models/medicine_catalog_response.dart';

abstract class IMedicineCatalogRepository {
  Future<MedicineResponse> getMedicinesCatalog({
    int limit = 8,
    int offset = 0,
    String sortDirection = 'ASC',
  });
  Future<MedicineCatalogModel> getMedicineCatalogById(String id);
}
