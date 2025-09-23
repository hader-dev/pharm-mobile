import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/repositories/remote/clients/params/params_my_clients.dart';
import 'package:hader_pharm_mobile/repositories/remote/clients/responses/response_my_clients.dart';

import 'actions/load_my_clients.dart' as actions;
import 'clients_repository.dart';

class ClientRepository extends IClientsRepository {
  final INetworkService client;
  final UserManager userManager;

  ClientRepository({required this.client, required this.userManager});

  @override
  Future<ResponseMyClients> getMyClients(ParamsLoadMyClients params) {
    return actions.loadMyClients(client, params);
  }
}
