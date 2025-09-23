import 'package:hader_pharm_mobile/repositories/remote/clients/params/params_my_clients.dart';
import 'package:hader_pharm_mobile/repositories/remote/clients/responses/response_my_clients.dart';

abstract class IClientsRepository {
  Future<ResponseMyClients> getMyClients(ParamsLoadMyClients params);
}
