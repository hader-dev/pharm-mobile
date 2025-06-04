import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/base_button.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

class LoginHeaderSection extends StatelessWidget {
  const LoginHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: AppSizesManager.p24, bottom: AppSizesManager.p32),
            padding: EdgeInsets.all(AppSizesManager.p16),
            alignment: Alignment.center,
            width: MediaQuery.sizeOf(context).width * .5,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(AppSizesManager.r4)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.accentGreenShade2,
                  AppColors.accent1Shade1,
                ],
              ),
            ),
            child: Text(
              'HADER PHARM',
              style: AppTypography.headLine3SemiBoldStyle.copyWith(
                color: AppColors.bgWhite,
              ),
            ),
          ),
          Text(
            'Sign In',
            style: AppTypography.headLine1Style.copyWith(fontSize: AppSizesManager.p24, color: AppColors.accent1Shade1),
          ),
          Gap(AppSizesManager.s8),
          Text(
            'Hi! Welcome back, you’ve been missed',
            style: AppTypography.body3RegularStyle.copyWith(color: TextColors.ternary.color),
          ),
        ],
      ),
    );
  }
}
