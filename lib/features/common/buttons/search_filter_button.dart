import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
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
          padding: EdgeInsets.symmetric(
              horizontal: context.responsiveAppSizeTheme.current.p12),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Icon(
                Iconsax.filter,
                size: context.responsiveAppSizeTheme.current.iconSize25,
                color: AppColors.accent1Shade1,
              ),
              if (hasActiveFilters)
                Positioned(
                  top: 12,
                  right: 3,
                  child: CircleAvatar(
                    radius: context
                        .responsiveAppSizeTheme.current.commonWidgetsRadius,
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
