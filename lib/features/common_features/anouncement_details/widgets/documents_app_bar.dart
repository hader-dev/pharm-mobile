import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart' show AppColors;
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class DocumentsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? customAppbarHeight;
  const DocumentsAppBar({super.key, this.customAppbarHeight});

  @override
  Widget build(BuildContext context) {
    return CustomAppBarV2.normal(
      topPadding: MediaQuery.of(context).padding.top,
      bottomPadding: MediaQuery.of(context).padding.bottom,
      leading: IconButton(
        icon: Icon(
          Directionality.of(context) == TextDirection.rtl ? Iconsax.arrow_right_3 : Iconsax.arrow_left_2,
          color: AppColors.accent1Shade1,
          size: context.responsiveAppSizeTheme.current.iconSize25,
        ),
        onPressed: () => context.pop(),
      ),
      title: Text(
        context.translation!.documents,
        style: context.responsiveTextTheme.current.headLine3SemiBold.copyWith(
          color: AppColors.accent1Shade1,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(customAppbarHeight ?? kToolbarHeight);
}
