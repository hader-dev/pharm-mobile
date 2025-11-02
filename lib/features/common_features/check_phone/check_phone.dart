import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../config/theme/colors_manager.dart';
import 'widgets/check_phone_header_section.dart';
import 'widgets/check_phone_otp_input_section.dart';

class CheckPhoneScreen extends StatelessWidget {
  const CheckPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgWhite,
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.responsiveAppSizeTheme.current.p16),
          child: Column(
            children: [
              CheckEmailHeaderSection(),
              const ResponsiveGap.s32(),
              CheckPhoneOtpInputSection(),
              const ResponsiveGap.s32(),
              Spacer(),
              Text.rich(
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 1.5),
                  TextSpan(children: [
                    TextSpan(
                      text: context.translation!.by_signing_up_you_agree_to_our,
                      style: context.responsiveTextTheme.current.body3Regular
                          .copyWith(color: TextColors.ternary.color),
                    ),
                    TextSpan(
                      text: ' ${context.translation!.terms_of_services} ',
                      style: context.responsiveTextTheme.current.body3Regular
                          .copyWith(
                              fontWeight: context.responsiveTextTheme.current
                                  .appFont.appFontSemiBold,
                              color: AppColors.accent1Shade1),
                    ),
                    TextSpan(
                      text: context.translation!.and,
                      style: context.responsiveTextTheme.current.body3Regular
                          .copyWith(color: TextColors.ternary.color),
                    ),
                    TextSpan(
                      text: context.translation!.privacy_policy,
                      style: context.responsiveTextTheme.current.body3Regular
                          .copyWith(
                              fontWeight: context.responsiveTextTheme.current
                                  .appFont.appFontSemiBold,
                              color: AppColors.accent1Shade1),
                    ),
                  ])),
              const ResponsiveGap.s12(),
            ],
          ),
        ),
      ),
    );
  }
}
