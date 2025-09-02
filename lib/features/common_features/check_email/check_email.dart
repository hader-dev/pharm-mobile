import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/go_router_extension.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/check_email/cubit/check_email_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'widgets/check_email_header_section.dart';
import 'widgets/check_email_otp_input_section.dart';

class CheckEmailScreen extends StatelessWidget {
  final String email;
  final String redirectTo;
  final bool popInsteadOfPushReplacement;
  const CheckEmailScreen(
      {super.key,
      required this.email,
      this.popInsteadOfPushReplacement = false,
      this.redirectTo = RoutingManager.congratulationScreen});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return BlocProvider(
      create: (context) =>
          CheckEmailCubit(userManager: getItInstance.get<UserManager>())
            ..initEmail(email),
      child: SafeArea(
        child: BlocListener<CheckEmailCubit, CheckEmailState>(
          listener: (context, state) {
            if (state is CheckEmailSuccuss) {
              if (popInsteadOfPushReplacement) {
                GoRouter.of(context).safePop();
              } else {
                GoRouter.of(context).pushReplacementNamed(redirectTo);
              }
            }
          },
          child: Scaffold(
            backgroundColor: AppColors.bgWhite,
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
              child: BlocBuilder<CheckEmailCubit, CheckEmailState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      CheckEmailHeaderSection(),
                      const ResponsiveGap.s32(),
                      CheckEmailOtpInputSection(),
                      const ResponsiveGap.s32(),
                      Spacer(),
                      Text.rich(
                          textAlign: TextAlign.center,
                          style: TextStyle(height: 1.5),
                          TextSpan(children: [
                            TextSpan(
                              text: translation.by_signing_up_you_agree_to_our,
                              style: context
                                  .responsiveTextTheme.current.body3Regular
                                  .copyWith(color: TextColors.ternary.color),
                            ),
                            TextSpan(
                              text: ' ${translation.terms_of_services} ',
                              style: context
                                  .responsiveTextTheme.current.body3Regular
                                  .copyWith(
                                      fontWeight: context.responsiveTextTheme
                                          .current.appFont.appFontSemiBold,
                                      color: AppColors.accent1Shade1),
                            ),
                            TextSpan(
                              text: ' ${translation.and} ',
                              style: context
                                  .responsiveTextTheme.current.body3Regular
                                  .copyWith(color: TextColors.ternary.color),
                            ),
                            TextSpan(
                              text: ' ${translation.privacy_policy}',
                              style: context
                                  .responsiveTextTheme.current.body3Regular
                                  .copyWith(
                                      fontWeight: context.responsiveTextTheme
                                          .current.appFont.appFontSemiBold,
                                      color: AppColors.accent1Shade1),
                            ),
                          ])),
                      const ResponsiveGap.s12(),
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
