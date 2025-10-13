import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/forgot_password/cubit/forgot_password_cubit.dart';

class ForgotPasswordStateProvider extends StatelessWidget {
  final Widget child;
  const ForgotPasswordStateProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ForgotPasswordCubit(userManager: getItInstance.get<UserManager>()),
      child: child,
    );
  }
}
