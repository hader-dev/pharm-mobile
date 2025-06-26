import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/features/common_features/check_email/cubit/check_email_cubit.dart';

import '../../../config/di/di.dart';
import '../../../config/routes/routing_manager.dart';
import '../../../config/services/auth/user_manager.dart';
import '../../../config/theme/colors_manager.dart';
import '../../../config/theme/typoghrapy_manager.dart';
import '../../../utils/constants.dart';
import 'widgets/check_email_header_section.dart';
import 'widgets/check_email_otp_input_section.dart';

class CheckEmailScreen extends StatelessWidget {
  final String email;
  final String redirectTo;
  const CheckEmailScreen({super.key, required this.email, this.redirectTo = RoutingManager.congratulationScreen});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckEmailCubit(userManager: getItInstance.get<UserManager>())..initEmail(email),
      child: SafeArea(
        child: BlocListener<CheckEmailCubit, CheckEmailState>(
          listener: (context, state) {
            if (state is CheckEmailSuccuss) {
              GoRouter.of(context).pushReplacementNamed(redirectTo);
            }
          },
          child: Scaffold(
            backgroundColor: AppColors.bgWhite,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
              child: BlocBuilder<CheckEmailCubit, CheckEmailState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      CheckEmailHeaderSection(),
                      Gap(AppSizesManager.s32),
                      CheckEmailOtpInputSection(),
                      Gap(AppSizesManager.s32),
                      Spacer(),
                      Text.rich(
                          textAlign: TextAlign.center,
                          style: TextStyle(height: 1.5),
                          TextSpan(children: [
                            TextSpan(
                              text: 'By Signing Up, you agree to our',
                              style: AppTypography.body3RegularStyle.copyWith(color: TextColors.ternary.color),
                            ),
                            TextSpan(
                              text: ' Terms of Services ',
                              style: AppTypography.body3RegularStyle
                                  .copyWith(fontWeight: AppTypography.appFontSemiBold, color: AppColors.accent1Shade1),
                            ),
                            TextSpan(
                              text: ' and',
                              style: AppTypography.body3RegularStyle.copyWith(color: TextColors.ternary.color),
                            ),
                            TextSpan(
                              text: ' Privacy Policy',
                              style: AppTypography.body3RegularStyle
                                  .copyWith(fontWeight: AppTypography.appFontSemiBold, color: AppColors.accent1Shade1),
                            ),
                          ])),
                      Gap(AppSizesManager.s12),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
