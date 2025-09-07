import 'dart:convert';

import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/repositories/remote/favorite/mappers/json_to_favorite_medicine.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<List<BaseMedicineCatalogModel>> getFavoritesMedicinesCatalogs(
    INetworkService client) async {
  final decodedResponse = await client.sendRequest(
      () => client.get(Urls.favoritesLikeMedicineCatalog, queryParams: {
            "include[medicineCatalog][_load]": jsonEncode(true),
            "include[company][_load]": jsonEncode(true)
          }));
  return (decodedResponse as List)
      .map((element) => jsonToFavoriteBaseMedicine(element))
      .toList();
}
