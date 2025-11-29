import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class PolicyAppbar extends StatelessWidget implements PreferredSizeWidget {
  const PolicyAppbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return CustomAppBarV2.normal(
      leading: IconButton(
        icon: Icon(
          Directionality.of(context) == TextDirection.rtl ? Iconsax.arrow_right_3 : Iconsax.arrow_left_2,
          color: AppColors.accent1Shade1,
          size: context.responsiveAppSizeTheme.current.iconSize25,
        ),
        onPressed: () {
          context.pop();
        },
      ),
      title: Text(
        translation.policy,
        style: context.responsiveTextTheme.current.headLine3SemiBold.copyWith(color: AppColors.accent1Shade1),
      ),
    );
  }
}
