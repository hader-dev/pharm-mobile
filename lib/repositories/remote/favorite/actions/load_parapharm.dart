import 'dart:convert';

import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/repositories/remote/favorite/mappers/json_to_favorite_parapharm.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<List<BaseParaPharmaCatalogModel>> getFavoritesParaPharmasCatalogs(
    INetworkService client) async {
  final decodedResponse = await client.sendRequest(
      () => client.get(Urls.favoritesLikeParaPharmaCatalog, queryParams: {
            "include[parapharmCatalog][_load]": jsonEncode(true),
            "include[company][_load]": jsonEncode(true)
          }));

  return (decodedResponse as List)
      .map((element) => jsonToFavoriteBaseParapharm(element))
      .toList();
}
