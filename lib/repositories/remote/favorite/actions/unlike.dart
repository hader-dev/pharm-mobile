import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<void> unLikeParaPharmaCatalog(
    {required String paraPharmaCatalogId,
    required INetworkService client}) async {
  await client.sendRequest(() => client.delete(
        "${Urls.favoritesUnLikeParaPharmaCatalog}/$paraPharmaCatalogId",
      ));
}

Future<void> unLikeMedicineCatalog(
    {required String medicineCatalogId,
    required INetworkService client}) async {
  await client.sendRequest(() => client.delete(
        "${Urls.favoritesUnlikeMedicineCatalog}/$medicineCatalogId",
      ));
}

Future<void> unLikeVendors(
    {required String vendorId, required INetworkService client}) async {
  await client.sendRequest(() => client.delete(
        "${Urls.favoritesUnlikeMedicineCatalog}/$vendorId",
      ));
}
