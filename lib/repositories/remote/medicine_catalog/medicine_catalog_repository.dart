import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/repositories/remote/medicine_catalog/response/medicine_catalog_response.dart';

import '../../../models/medicines_filters.dart' show MedicinesFilters;

abstract class IMedicineCatalogRepository {
  Future<MedicineResponse> getMedicinesCatalog(
      {int limit = 8,
      int offset = 0,
      String sortDirection = 'DESC',
      String? searchValue,
      MedicinesFilters filters = const MedicinesFilters()});
  Future<MedicineCatalogModel> getMedicineCatalogById(String id);
}
