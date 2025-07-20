import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../config/theme/colors_manager.dart';
import '../../../../config/theme/typoghrapy_manager.dart';
import '../../../../utils/constants.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final Function()? onTap;
  const SettingsTile({
    required this.icon,
    required this.title,
    this.trailing,
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizesManager.p10, left: AppSizesManager.p8, right: AppSizesManager.p8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.accentGreenShade1.withAlpha(40), width: 1),
          borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            size: AppSizesManager.iconSize20,
            color: const Color.fromARGB(179, 20, 112, 130),
          ),
          title: Text(
            title,
            style: AppTypography.body3MediumStyle,
          ),
          trailing: trailing ??
              Icon(
                Directionality.of(context) == TextDirection.rtl ? Iconsax.arrow_left_2 : Iconsax.arrow_right_3,
                size: AppSizesManager.iconSize20,
              ),
          onTap: () {
            onTap?.call();
          },
        ),
      ),
    );
  }
}
