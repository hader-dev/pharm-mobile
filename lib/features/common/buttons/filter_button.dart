import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:iconsax/iconsax.dart';

class FloatingFilter extends StatelessWidget {
  const FloatingFilter(
      {super.key,
      this.onTap,
      this.isFloatingStyle = false,
      this.hasBadge = false});
  final VoidCallback? onTap;
  final bool isFloatingStyle;
  final bool hasBadge;

  const FloatingFilter.floating({
    super.key,
    required this.onTap,
  })  : isFloatingStyle = true,
        hasBadge = false;

  @override
  Widget build(BuildContext context) {
    if (isFloatingStyle) {
      return InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.accent1Shade1,
            shape: BoxShape.circle,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Icon(
                Iconsax.filter,
                color: AppColors.bgWhite,
                size: 28,
              ),
              if (hasBadge)
                const Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: Colors.red,
                  ),
                )
            ],
          ),
        ),
      );
    }

    // Default style
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p12),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(
              Iconsax.filter,
              color: AppColors.accent1Shade1,
            ),
            if (hasBadge)
              Positioned(
                top: -4,
                right: -4,
                child: CircleAvatar(
                  radius: AppSizesManager.commonWidgetsRadius,
                  backgroundColor: Colors.red,
                ),
              )
          ],
        ),
      ),
    );
  }
}
