import 'dart:convert';

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
    final decodedResponse = await client.sendRequest(() => client
        .get(Urls.favoritesLikeMedicineCatalog, queryParams: {"include[medicineCatalog][_load]": jsonEncode(true)}));
    return (decodedResponse as List)
        .map((element) => BaseMedicineCatalogModel.fromJson(element["medicineCatalog"]))
        .toList();
  }

  @override
  Future<List<BaseParaPharmaCatalogModel>> getFavoritesParaPharmasCatalogs() async {
    final decodedResponse = await client.sendRequest(() => client
        .get(Urls.favoritesLikeParaPharmaCatalog, queryParams: {"include[parapharmCatalog][_load]": jsonEncode(true)}));
    return (decodedResponse as List)
        .map((element) => BaseParaPharmaCatalogModel.fromJson(element["parapharmCatalog"]))
        .toList();
  }

  @override
  Future<List<Company>> getFavoritesVendors() async {
    final decodedResponse = await client.sendRequest(
        () => client.get(Urls.favoritesCompany, queryParams: {"include[favoriteCompany][_load]": jsonEncode(true)}));
    return (decodedResponse as List)
        .map((favoriteCOmpanyObject) => Company.fromJson(favoriteCOmpanyObject["favoriteCompany"]))
        .toList();
  }

  @override
  Future<void> likeMedicineCatalog({required String medicineCatalogId}) async {
    await client.sendRequest(
        () => client.post(Urls.favoritesLikeMedicineCatalog, payload: {"medicineCatalogId": medicineCatalogId}));
  }

  @override
  Future<void> likeParaPharmaCatalog({required String paraPharmaCatalogId}) async {
    await client.sendRequest(
        () => client.post(Urls.favoritesLikeParaPharmaCatalog, payload: {"parapharmCatalogId": paraPharmaCatalogId}));
  }

  @override
  Future<void> likeVendors({required String vendorId}) async {
    await client.sendRequest(() => client.post(Urls.favoritesCompany, payload: {"favoriteCompanyId": vendorId}));
  }

  @override
  Future<void> unLikeMedicineCatalog({required String medicineCatalogId}) async {
    await client.sendRequest(() => client.delete(
          "${Urls.favoritesUnlikeMedicineCatalog}/$medicineCatalogId",
        ));
  }

  @override
  Future<void> unLikeParaPharmaCatalog({required String paraPharmaCatalogId}) async {
    await client.sendRequest(() => client.delete(
          "${Urls.favoritesUnLikeParaPharmaCatalog}/$paraPharmaCatalogId",
        ));
  }

  @override
  Future<void> unLikeVendors({required String vendorId}) async {
    //TODO: unLikeVendors refactore this func when mohammed add delete fav company by FK
    await client.sendRequest(() => client.delete(
          "${Urls.favoritesUnlikeMedicineCatalog}/$vendorId",
        ));
  }
}
