import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class LoginHeaderSection extends StatelessWidget {
  const LoginHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: AppSizesManager.p32, bottom: AppSizesManager.p32),
            padding: EdgeInsets.all(AppSizesManager.p16),
            alignment: Alignment.center,
            width: MediaQuery.sizeOf(context).width * .5,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSizesManager.r4)),
            ),
            child: SvgPicture.asset(
              DrawableAssetStrings.logoImg,
              height: 120,
              width: 120,
            ),
          ),
          Text(
            context.translation!.sign_in,
            style: context.responsiveTextTheme.current.headLine1.copyWith(
                fontSize: AppSizesManager.p24, color: AppColors.accent1Shade1),
          ),
          const ResponsiveGap.s8(),
          Text(
            context.translation!.welcome_back,
            style: context.responsiveTextTheme.current.body3Regular
                .copyWith(color: TextColors.ternary.color),
          ),
        ],
      ),
    );
  }
}
