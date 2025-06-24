import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/theme/colors_manager.dart';
import '../../../config/theme/typoghrapy_manager.dart';
import '../../../utils/constants.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
          child: Column(
            children: [
              CheckEmailHeaderSection(),
              Gap(AppSizesManager.s32),
              CheckPhoneOtpInputSection(),
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
          ),
        ),
      ),
    );
  }
}
