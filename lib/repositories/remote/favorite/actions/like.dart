import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<void> likeParaPharmaCatalog(
    {required String paraPharmaCatalogId,
    required INetworkService client}) async {
  await client.sendRequest(() => client.post(
      Urls.favoritesLikeParaPharmaCatalog,
      payload: {"parapharmCatalogId": paraPharmaCatalogId}));
}

Future<void> likeMedicineCatalog(
    {required String medicineCatalogId,
    required INetworkService client}) async {
  await client.sendRequest(() => client.post(Urls.favoritesLikeMedicineCatalog,
      payload: {"medicineCatalogId": medicineCatalogId}));
}

Future<void> likeVendors(
    {required String vendorId, required INetworkService client}) async {
  await client.sendRequest(() => client
      .post(Urls.favoritesCompany, payload: {"favoriteCompanyId": vendorId}));
}
