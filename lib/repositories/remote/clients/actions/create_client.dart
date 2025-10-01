import 'package:flutter/foundation.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/repositories/remote/clients/mappers/json_to_create_client.dart';
import 'package:hader_pharm_mobile/repositories/remote/clients/params/params_create_client.dart';
import 'package:hader_pharm_mobile/repositories/remote/clients/responses/response_create_client.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<ResponseCreateClient> createClient(
    INetworkService client, ParamsCreateClient params) async {
  var decodedResponse = await client.sendRequest(
      () => client.post(Urls.deligateCreateClient, payload: params.toJson()));

  try {
    return jsonToResponseCreateClient(decodedResponse);
  } catch (e, stackTrace) {
    debugPrint("$e");
    debugPrintStack(stackTrace: stackTrace);

    return ResponseCreateClient.failed();
  }
}
