
import 'package:hader_pharm_mobile/models/medical_filters.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog_response.dart';

abstract class IMedicineCatalogRepository {
  Future<MedicineResponse> getMedicinesCatalog(
      {int limit = 8,
      int offset = 0,
      String sortDirection = 'ASC',
      MedicalFilters filters = const MedicalFilters()}); 
  Future<MedicineCatalogModel> getMedicineCatalogById(String id);
}
