import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';

import 'actions/like.dart' as actions;
import 'actions/load_medicine.dart' as actions;
import 'actions/load_parapharm.dart' as actions;
import 'actions/load_vendors.dart' as actions;
import 'actions/unlike.dart' as actions;
import 'favorite_repository.dart';

class FavoriteRepository extends IFavoriteRepository {
  final INetworkService client;
  FavoriteRepository({required this.client});

  @override
  Future<List<BaseMedicineCatalogModel>> getFavoritesMedicinesCatalogs() async {
    return actions.getFavoritesMedicinesCatalogs(client);
  }

  @override
  Future<List<BaseParaPharmaCatalogModel>>
      getFavoritesParaPharmasCatalogs() async {
    return actions.getFavoritesParaPharmasCatalogs(client);
  }

  @override
  Future<List<Company>> getFavoritesVendors() async {
    return actions.getFavoritesVendors(client);
  }

  @override
  Future<void> likeMedicineCatalog({required String medicineCatalogId}) async {
    return actions.likeMedicineCatalog(
        medicineCatalogId: medicineCatalogId, client: client);
  }

  @override
  Future<void> likeParaPharmaCatalog(
      {required String paraPharmaCatalogId}) async {
    return actions.likeParaPharmaCatalog(
        paraPharmaCatalogId: paraPharmaCatalogId, client: client);
  }

  @override
  Future<void> likeVendors({required String vendorId}) async {
    return actions.likeVendors(vendorId: vendorId, client: client);
  }

  @override
  Future<void> unLikeMedicineCatalog(
      {required String medicineCatalogId}) async {
    return actions.unLikeMedicineCatalog(
        medicineCatalogId: medicineCatalogId, client: client);
  }

  @override
  Future<void> unLikeParaPharmaCatalog(
      {required String paraPharmaCatalogId}) async {
    return actions.unLikeParaPharmaCatalog(
        paraPharmaCatalogId: paraPharmaCatalogId, client: client);
  }

  @override
  Future<void> unLikeVendors({required String vendorId}) async {
    return actions.unLikeVendors(vendorId: vendorId, client: client);
  }
}
