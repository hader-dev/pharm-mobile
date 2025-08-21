import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../config/theme/colors_manager.dart';
import '../../../../utils/assets_strings.dart';
import '../../../../utils/constants.dart';

class CongratulationHeaderSection extends StatelessWidget {
  const CongratulationHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Gap(AppSizesManager.s24),
          SvgPicture.asset(DrawableAssetStrings.tickCircleIcon,
              height: AppSizesManager.iconSize48,
              width: AppSizesManager.iconSize48),
          Gap(AppSizesManager.s6),
          Text(
            'Congratulations!',
            style: context.responsiveTextTheme.current.headLine1.copyWith(
                fontSize: AppSizesManager.p24, color: AppColors.accent1Shade1),
          ),
          Gap(AppSizesManager.s6),
          Text(
            'Your profile is now complete.',
            style: context.responsiveTextTheme.current.body3Regular
                .copyWith(color: TextColors.ternary.color),
          ),
        ],
      ),
    );
  }
}
