import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart' show DrawableAssetStrings;
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class ProfileAppBar extends StatelessWidget {
  final bool isExtraLargeScreen;
  const ProfileAppBar({
    super.key,
    required this.isExtraLargeScreen,
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
          child: SvgPicture.asset(DrawableAssetStrings.newProfileIcon,
              height: context.responsiveAppSizeTheme.current.iconSize25,
              width: context.responsiveAppSizeTheme.current.iconSize25,
              colorFilter: ColorFilter.mode(
                AppColors.accent1Shade1,
                BlendMode.srcIn,
              ))),
      title: Text(
        context.translation!.account,
        style: context.responsiveTextTheme.current.headLine2.copyWith(color: AppColors.accent1Shade1),
      ),
    );
  }
}
