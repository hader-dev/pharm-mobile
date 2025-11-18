import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:hader_pharm_mobile/config/responsive/device_size.dart' show DeviceSizes, DeviceSizesExtension;
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/actions/navigate_back.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart' show DrawableAssetStrings;
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class NotificationAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NotificationAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return CustomAppBarV2.normal(
      topPadding: MediaQuery.of(context).padding.top,
      bottomPadding: MediaQuery.of(context).padding.bottom,
      leading: IconButton(
        icon: Icon(Directionality.of(context) == TextDirection.rtl ? Iconsax.arrow_right_3 : Iconsax.arrow_left_2,
            size: context.responsiveAppSizeTheme.current.iconSize25, color: AppColors.accent1Shade1),
        onPressed: () => handleNavigateBack(context),
      ),
      title: Row(
        children: [
          SvgPicture.asset(
            DrawableAssetStrings.newNotificationIcon,
            colorFilter: ColorFilter.mode(AppColors.accent1Shade1, BlendMode.srcIn),
            height: context.deviceSize.width <= DeviceSizes.largeMobile.width
                ? context.responsiveAppSizeTheme.current.iconSize25
                : context.responsiveAppSizeTheme.current.iconSize18,
          ),
          const ResponsiveGap.s12(),
          Text(
            context.translation!.notifications,
            style: context.responsiveTextTheme.current.headLine3SemiBold.copyWith(color: AppColors.accent1Shade1),
          ),
        ],
      ),
    );
  }
}
