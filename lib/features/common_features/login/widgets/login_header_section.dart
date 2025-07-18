import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../config/theme/colors_manager.dart';
import '../../../../config/theme/typoghrapy_manager.dart';
import '../../../../utils/assets_strings.dart';
import '../../../../utils/constants.dart';

class LoginHeaderSection extends StatelessWidget {
  const LoginHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: AppSizesManager.p32, bottom: AppSizesManager.p32),
            padding: EdgeInsets.all(AppSizesManager.p16),
            alignment: Alignment.center,
            width: MediaQuery.sizeOf(context).width * .5,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(AppSizesManager.r4)),
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: [
              //     AppColors.accentGreenShade2,
              //     AppColors.accent1Shade1,
              //   ],
              // ),
            ),
            child: SvgPicture.asset(
              DrawableAssetStrings.logoImg,
              height: 120,
              width: 120,
            ),
          ),
          Text(
            context.translation!.signIn,
            style: AppTypography.headLine1Style.copyWith(fontSize: AppSizesManager.p24, color: AppColors.accent1Shade1),
          ),
          Gap(AppSizesManager.s8),
          Text(
            context.translation!.welcomeBack,
            style: AppTypography.body3RegularStyle.copyWith(color: TextColors.ternary.color),
          ),
        ],
      ),
    );
  }
}
