import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/delegate/deligate_create_client/cubit/cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/wilaya/cubit/wilaya_cubit.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/wilaya_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/clients/clients_repository_impl.dart';

class DeligateCreateClientStateProvider extends StatelessWidget {
  const DeligateCreateClientStateProvider({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => DeligateCreateClientCubit(
          clientsRepo: ClientRepository(
              client: getItInstance.get<INetworkService>(), userManager: getItInstance.get<UserManager>()),
        ),
      ),
      BlocProvider(
        create: (context) => WilayaCubit(
          wilayaRepository: WilayaRepositoryImpl(),
        ),
      ),
    ], child: child);
  }
}
