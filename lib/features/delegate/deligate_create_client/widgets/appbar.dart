import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/language_config/resources/app_localizations.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart' show Iconsax;

import '../../../../config/theme/colors_manager.dart' show AppColors;

class DelegateCreateClientAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DelegateCreateClientAppBar({
    super.key,
    required this.translation,
  });

  final AppLocalizations translation;

  @override
  Widget build(BuildContext context) {
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
        translation.add_client,
        style: context.responsiveTextTheme.current.headLine3SemiBold.copyWith(
          color: AppColors.accent1Shade1,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
