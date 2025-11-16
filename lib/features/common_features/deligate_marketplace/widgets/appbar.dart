import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart' show AppColors;
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/assets_strings.dart' show DrawableAssetStrings;

class DeligateMarketplaceAppbar extends StatelessWidget {
  const DeligateMarketplaceAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBarV2.normal(
      topPadding: context.responsiveAppSizeTheme.current.p16,
      bottomPadding: context.responsiveAppSizeTheme.current.p16,
      rightPadding: context.responsiveAppSizeTheme.current.p8,
      leftPadding: context.responsiveAppSizeTheme.current.p8,
      leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.responsiveAppSizeTheme.current.p8),
          child: SvgPicture.asset(DrawableAssetStrings.newMarketIcon,
              height: context.responsiveAppSizeTheme.current.iconSize20,
              width: context.responsiveAppSizeTheme.current.iconSize20,
              colorFilter: ColorFilter.mode(
                AppColors.accent1Shade1,
                BlendMode.srcIn,
              ))),
      title: Text(
        context.translation!.market_place,
        style: context.responsiveTextTheme.current.headLine2.copyWith(
          color: AppColors.accent1Shade1,
        ),
      ),
      trailing: [],
    );
  }
}
