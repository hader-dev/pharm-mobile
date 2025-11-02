import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

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
              context.translation!.welcome_to_hader,
              style: context.responsiveTextTheme.current.headLine3SemiBold,
            ),
            const ResponsiveGap.s16(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveAppSizeTheme.current.p8),
              child: Text(
                context.translation!.we_wish_you_good_health_welcome,
                style: context.responsiveTextTheme.current.body3Regular,
                textAlign: TextAlign.center,
              ),
            ),
            const ResponsiveGap.s16(),
            PrimaryTextButton(
                label: context.translation!.close,
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
