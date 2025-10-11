import 'package:flutter/foundation.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/repositories/remote/clients/mappers/json_to_client.dart';
import 'package:hader_pharm_mobile/repositories/remote/clients/params/params_my_clients.dart';
import 'package:hader_pharm_mobile/repositories/remote/clients/responses/response_my_clients.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<ResponseMyClients> loadMyClients(
    INetworkService client, ParamsLoadMyClients params) async {
  var decodedResponse =
      await client.sendRequest(() => client.get(Urls.myClients, queryParams: {
            'limit': params.limit.toString(),
            'offset': params.offset.toString(),
            'filters[includeBuyerCompany]': 'true',
            if (params.searchQuery?.isNotEmpty ?? false)
              'search[clientName]': params.searchQuery!
          }));

  try {
    return jsonToResponseMyClients(decodedResponse);
  } catch (e, stackTrace) {
    debugPrint("$e");
    debugPrintStack(stackTrace: stackTrace);

    return ResponseMyClients(
      clients: [],
      totalItems: 0,
    );
  }
}
