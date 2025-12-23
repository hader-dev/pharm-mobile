import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_clients/cubit/delegate_clients_cubit.dart';
import 'package:hader_pharm_mobile/repositories/remote/clients/clients_repository_impl.dart';

class DelegateClientsStateProvider extends StatelessWidget {
  const DelegateClientsStateProvider({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DelegateClientsCubit(
              clientsRepo: ClientRepository(
                  client: getItInstance.get<INetworkService>(), userManager: getItInstance.get<UserManager>()),
              scrollController: ScrollController(),
              searchController: TextEditingController(),
            )..getClients(),
        child: child);
  }
}
