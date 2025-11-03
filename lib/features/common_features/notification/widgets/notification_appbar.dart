import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/actions/navigate_back.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class NotificationAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const NotificationAppbar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return CustomAppBarV2.alternate(
      topPadding: MediaQuery.of(context).padding.top,
      bottomPadding: MediaQuery.of(context).padding.bottom,
      leading: IconButton(
        icon: Icon(
            Directionality.of(context) == TextDirection.rtl
                ? Iconsax.arrow_right_3
                : Iconsax.arrow_left_2,
            size: context.responsiveAppSizeTheme.current.iconSize25,
            color: AppColors.bgWhite),
        onPressed: () => handleNavigateBack(context),
      ),
      title: Row(
        children: [
          Icon(Iconsax.notification,
              size: context.responsiveAppSizeTheme.current.iconSize25,
              color: AppColors.bgWhite),
          const ResponsiveGap.s12(),
          Text(
            context.translation!.notifications,
            style: context.responsiveTextTheme.current.headLine3SemiBold
                .copyWith(color: AppColors.bgWhite),
          ),
        ],
      ),
    );
  }
}
