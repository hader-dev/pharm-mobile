import '../../../repositories/remote/user/user_repository_impl.dart';
import '../../../utils/shared_prefs.dart';
import '../../config/di/di.dart';
import '../../config/services/network/network_interface.dart';
import 'cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/assets_strings.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocProvider(
        create: (context) => SplashCubit(UserRepository(client: getItInstance.get<INetworkService>()))..init(),
        child: BlocBuilder<SplashCubit, SplashState>(
          builder: (context, state) {
            return Scaffold(
              body: Center(
                  child: Text(
                'Splash Screen',
              )),
            );
          },
        ),
      );
    });
  }
}
