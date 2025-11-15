import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class DeligateClientsAppbar extends StatelessWidget implements PreferredSizeWidget {
  const DeligateClientsAppbar({
    super.key,
    required bool isExtraLargeScreen,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBarV2.alternate(
      topPadding: MediaQuery.of(context).padding.top,
      bottomPadding: MediaQuery.of(context).padding.bottom,
      leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.responsiveAppSizeTheme.current.p8),
          child: SvgPicture.asset(DrawableAssetStrings.newClientsIcon,
              height: context.responsiveAppSizeTheme.current.iconSize20,
              width: context.responsiveAppSizeTheme.current.iconSize20,
              colorFilter: ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ))),
      title: Text(
        context.translation!.client,
        style: context.responsiveTextTheme.current.headLine3SemiBold.copyWith(color: AppColors.bgWhite),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
