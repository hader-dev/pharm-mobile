import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common_features/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/forgot_password/cubit/provider.dart';
import 'package:hader_pharm_mobile/features/common_features/forgot_password/widgets/forgot_password_bottom_sheet.dart';
import 'package:hader_pharm_mobile/features/common_features/forgot_password/widgets/forgot_password_otp_bottom_sheet.dart';
import 'package:hader_pharm_mobile/features/common_features/forgot_password/widgets/password_reset_sucess_bottom_sheet.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ForgotPasswordStateProvider(
      child: BlocBuilder<ForgotPasswordCubit, ForgotPaswordState>(
        builder: (context, state) {
          debugPrint("State: $state");

          if (state is ResetPasswordSuccess) {
            return const PasswordResetSuccessSentScreen();
          }

          if (state is PasswordResetOtpScreen ||
              state is PasswordVisibilityChanged ||
              state is TimerCountChanged ||
              state is ResetpasswordIsLoading ||
              state is ResetLinkSent ||
              state is ResendOtpLoading ||
              state is ResetPasswordFailed) {
            return const PasswordResetOtpScreen();
          }

          return const RequestForgotPasswordScreen();
        },
      ),
    );
  }
}
