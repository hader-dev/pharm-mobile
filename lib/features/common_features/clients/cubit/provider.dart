import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common_features/clients/cubit/clients_cubit.dart';
import 'package:hader_pharm_mobile/repositories/remote/clients/clients_repository_impl.dart';

class DeligateClientsStateProvider extends StatelessWidget {
  const DeligateClientsStateProvider({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DeligateClientsCubit(
              clientsRepo: ClientRepository(
                  client: getItInstance.get<INetworkService>(),
                  userManager: getItInstance.get<UserManager>()),
              scrollController: ScrollController(),
              searchController: TextEditingController(),
            )..getClients(),
        child: child);
  }
}
