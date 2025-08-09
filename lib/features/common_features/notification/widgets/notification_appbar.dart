import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/actions/navigate_back.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class NotificationAppbar extends StatelessWidget  implements PreferredSizeWidget {
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
          Directionality.of(context) == TextDirection.rtl ? Iconsax.arrow_right_3 : Iconsax.arrow_left_2,
          size: AppSizesManager.iconSize25,
          color: AppColors.bgWhite
        ),
        onPressed: () => handleNavigateBack(context),
      ),
      title: Row(
        children: [
          const Icon(
            Iconsax.box_2,
            size: AppSizesManager.iconSize25,
            color: AppColors.bgWhite
          ),
          Gap(AppSizesManager.s12),
          Text(
            context.translation!.notifications,
            style: AppTypography.headLine3SemiBoldStyle.copyWith(color: AppColors.bgWhite),
            
          ),
        ],
      ),
      
    );
  }
}