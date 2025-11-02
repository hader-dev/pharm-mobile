import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
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
                top: context.responsiveAppSizeTheme.current.p32,
                bottom: context.responsiveAppSizeTheme.current.p32),
            padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p16),
            alignment: Alignment.center,
            width: MediaQuery.sizeOf(context).width * .5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(context.responsiveAppSizeTheme.current.r4)),
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
                fontSize: context.responsiveAppSizeTheme.current.p24,
                color: AppColors.accent1Shade1),
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
