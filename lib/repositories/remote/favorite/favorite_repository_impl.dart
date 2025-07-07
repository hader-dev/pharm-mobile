import '../../../config/services/network/network_interface.dart';

import '../../../models/company.dart';
import '../../../models/medicine_catalog.dart';
import '../../../models/para_pharma.dart';
import '../../../utils/urls.dart';
import 'favorite_repository.dart';

class FavoriteRepository extends IFavoriteRepository {
  final INetworkService client;
  FavoriteRepository({required this.client});

  @override
  Future<List<BaseMedicineCatalogModel>> getFavoritesMedicinesCatalogs() async {
    final decodedResponse = await client.sendRequest(() => client.get(Urls.favoritesMedicineCatalog));
    return (decodedResponse as List)
        .map((element) => BaseMedicineCatalogModel.fromJson(element["medicineCatalogId"]))
        .toList();
  }

  @override
  Future<List<BaseParaPharmaCatalogModel>> getFavoritesParaPharmasCatalogs() async {
    final decodedResponse = await client.sendRequest(() => client.get(Urls.favoritesParaPharmaCatalog));
    return (decodedResponse as List)
        .map((element) => BaseParaPharmaCatalogModel.fromJson(element["parapharmCatalog"]))
        .toList();
  }

  @override
  Future<List<Company>> getFavoritesVendors() async {
    final decodedResponse = await client.sendRequest(() => client.get(Urls.favoritesMedicineCatalog));
    return (decodedResponse as List).map((element) => Company.fromJson(element["favoriteCompany"])).toList();
  }

  @override
  Future<void> likeMedicineCatalog({required String medicineCatalogId}) async {
    await client.sendRequest(
        () => client.post(Urls.favoritesMedicineCatalog, payload: {"medicineCatalogId": medicineCatalogId}));
  }

  @override
  Future<void> likeParaPharmaCatalog({required String paraPharmaCatalogId}) async {
    await client.sendRequest(
        () => client.post(Urls.favoritesMedicineCatalog, payload: {"parapharmCatalogId": paraPharmaCatalogId}));
  }

  @override
  Future<void> likeVendors({required String vendorId}) async {
    await client
        .sendRequest(() => client.post(Urls.favoritesMedicineCatalog, payload: {"favoriteCompanyId": vendorId}));
  }

  @override
  Future<void> unLikeMedicineCatalog({required String medicineCatalogId}) async {
    await client.sendRequest(() => client.delete(
          "${Urls.favoritesMedicineCatalog}/$medicineCatalogId",
        ));
  }

  @override
  Future<void> unLikeParaPharmaCatalog({required String paraPharmaCatalogId}) async {
    await client.sendRequest(() => client.delete(
          "${Urls.favoritesMedicineCatalog}/$paraPharmaCatalogId",
        ));
  }

  @override
  Future<void> unLikeVendors({required String vendorId}) async {
    await client.sendRequest(() => client.delete(
          "${Urls.favoritesMedicineCatalog}/$vendorId",
        ));
  }
}
