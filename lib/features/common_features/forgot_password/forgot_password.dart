import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/forgot_password/widgets/forgot_password_bottom_sheet.dart';
import 'package:hader_pharm_mobile/features/common_features/forgot_password/widgets/forgot_password_otp_bottom_sheet.dart';
import 'package:hader_pharm_mobile/features/common_features/forgot_password/widgets/password_reset_sucess_bottom_sheet.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ForgotPasswordCubit(userManager: getItInstance.get<UserManager>()),
      child: BlocBuilder<ForgotPasswordCubit, ForgotPaswordState>(
        builder: (context, state) {
          if (state is ResetPasswordSuccess) {
            return PasswordResetSuccessSentScreen();
          }

          if (state is ForgotPasswordEmailStart ||
              state is ForgotPasswordInitial) {
            return const RequestForgotPasswordScreen();
          }

          return PasswordResetOtpScreen();
        },
      ),
    );
  }
}
