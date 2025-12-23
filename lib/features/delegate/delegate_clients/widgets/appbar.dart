import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class DelegateClientsAppBar extends StatelessWidget {
  const DelegateClientsAppBar({
    super.key,
    required bool isExtraLargeScreen,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBarV2.normal(
      topPadding: context.responsiveAppSizeTheme.current.p8,
      bottomPadding: context.responsiveAppSizeTheme.current.p8,
      rightPadding: context.responsiveAppSizeTheme.current.p8,
      leftPadding: context.responsiveAppSizeTheme.current.p8,
      leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.responsiveAppSizeTheme.current.p8),
          child: SvgPicture.asset(DrawableAssetStrings.newClientsIcon,
              height: context.responsiveAppSizeTheme.current.iconSize20,
              width: context.responsiveAppSizeTheme.current.iconSize20,
              colorFilter: ColorFilter.mode(
                AppColors.accent1Shade1,
                BlendMode.srcIn,
              ))),
      title: Text(
        context.translation!.client,
        style: context.responsiveTextTheme.current.headLine3SemiBold.copyWith(
          color: AppColors.accent1Shade1,
        ),
      ),
    );
  }
}
