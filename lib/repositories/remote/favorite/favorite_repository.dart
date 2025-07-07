import 'package:hader_pharm_mobile/models/para_pharma.dart';

import '../../../models/company.dart';
import '../../../models/medicine_catalog.dart';

abstract class IFavoriteRepository {
  Future<List<BaseMedicineCatalogModel>> getFavoritesMedicinesCatalogs();
  Future<List<BaseParaPharmaCatalogModel>> getFavoritesParaPharmasCatalogs();
  Future<List<Company>> getFavoritesVendors();
  Future<void> likeMedicineCatalog({required String medicineCatalogId});
  Future<void> likeParaPharmaCatalog({required String paraPharmaCatalogId});
  Future<void> likeVendors({required String vendorId});
  Future<void> unLikeMedicineCatalog({required String medicineCatalogId});
  Future<void> unLikeParaPharmaCatalog({required String paraPharmaCatalogId});
  Future<void> unLikeVendors({required String vendorId});
}
