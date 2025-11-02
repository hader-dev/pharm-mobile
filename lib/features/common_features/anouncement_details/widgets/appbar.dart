import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class AnnouncementDetailsAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final double? customAppbarHeight;
  const AnnouncementDetailsAppbar({super.key, this.customAppbarHeight});

  @override
  Widget build(BuildContext context) {
    return CustomAppBarV2.alternate(
      topPadding: MediaQuery.of(context).padding.top,
      bottomPadding: MediaQuery.of(context).padding.bottom,
      leading: IconButton(
        icon: Icon(
          Iconsax.arrow_left,
          color: Colors.white,
          size: context.responsiveAppSizeTheme.current.iconSize25,
        ),
        onPressed: () => context.pop(),
      ),
      title: Text(
        context.translation!.announcement_details,
        style: context.responsiveTextTheme.current.headLine3SemiBold.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(customAppbarHeight ?? kToolbarHeight);
}
