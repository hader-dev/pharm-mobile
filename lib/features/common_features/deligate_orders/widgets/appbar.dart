import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class DeligateOrdersAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const DeligateOrdersAppbar({
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
        icon: const Icon(
          Iconsax.bag_2,
          size: AppSizesManager.iconSize25,
          color: AppColors.bgWhite,
        ),
        onPressed: () {},
      ),
      title: Text(
        context.translation!.orders,
        style: context.responsiveTextTheme.current.headLine3SemiBold
            .copyWith(color: AppColors.bgWhite),
      ),
    );
  }
}
