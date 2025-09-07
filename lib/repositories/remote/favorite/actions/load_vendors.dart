import 'dart:convert';

import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/mappers/json_to_company.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<List<Company>> getFavoritesVendors(INetworkService client) async {
  final decodedResponse = await client.sendRequest(() => client.get(
      Urls.favoritesCompany,
      queryParams: {"include[favoriteCompany][_load]": jsonEncode(true)}));
  return (decodedResponse as List)
      .map((favoriteCOmpanyObject) =>
          jsonToCompany(favoriteCOmpanyObject["favoriteCompany"]))
      .toList();
}
