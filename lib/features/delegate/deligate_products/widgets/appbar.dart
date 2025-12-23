import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class DeligateProductsAppbar extends StatelessWidget implements PreferredSizeWidget {
  const DeligateProductsAppbar({
    super.key,
    required bool isExtraLargeScreen,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBarV2.normal(
      topPadding: MediaQuery.of(context).padding.top,
      bottomPadding: MediaQuery.of(context).padding.bottom,
      leading: IconButton(
        icon: Icon(
          Iconsax.shop,
          color: Colors.white,
          size: context.responsiveAppSizeTheme.current.iconSize25,
        ),
        onPressed: () {},
      ),
      title: Text(
        context.translation!.market_place,
        style: context.responsiveTextTheme.current.headLine3SemiBold.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
