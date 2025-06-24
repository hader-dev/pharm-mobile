import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';

import '../../../config/theme/colors_manager.dart';
import '../../../config/theme/typoghrapy_manager.dart';
import '../../../utils/assets_strings.dart' show DrawableAssetStrings;
import '../../../utils/constants.dart';

class WelcomingWidget extends StatelessWidget {
  const WelcomingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          width: double.maxFinite,
          height: 170,
          child: Image.asset(
            DrawableAssetStrings.welcomingBg,
            fit: BoxFit.fitWidth,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset(
                  DrawableAssetStrings.doctoreIllustration,
                  height: 200,
                ),
                Container(
                  color: Colors.white,
                  height: 28,
                  width: double.maxFinite,
                )
              ],
            ),
            Text(
              'Welcome to Hader Pharm',
              style: AppTypography.headLine3SemiBoldStyle,
            ),
            Gap(AppSizesManager.s16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p8),
              child: Text(
                'We wish you a good experience , your health is our priority.',
                style: AppTypography.body3RegularStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Gap(AppSizesManager.s16),
            PrimaryTextButton(
                label: "Close",
                labelColor: AppColors.accent1Shade1,
                onTap: () {
                  context.pop();
                },
                color: Colors.transparent),
          ],
        )
      ],
    ));
  }
}
