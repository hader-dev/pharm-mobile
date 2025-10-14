import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:iconsax/iconsax.dart';

class SearchFilterButton extends StatelessWidget {
  const SearchFilterButton({
    super.key,
    required this.hasActiveFilters,
    required this.onTap,
  });

  final bool hasActiveFilters;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kBottomNavigationBarHeight,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p12),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              const Icon(
                Iconsax.filter,
                size: AppSizesManager.iconSize25,
                color: AppColors.accent1Shade1,
              ),
              if (hasActiveFilters)
                Positioned(
                  top: 12,
                  right: 3,
                  child: CircleAvatar(
                    radius: AppSizesManager.commonWidgetsRadius,
                    backgroundColor: Colors.red,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
