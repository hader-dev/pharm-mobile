import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/language_config/resources/app_localizations.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class FiltersButtonOrder extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final bool isActive;
  const FiltersButtonOrder(
      {super.key,
      required this.isActive,
      required this.icon,
      required this.label,
      this.onPressed});

  factory FiltersButtonOrder.filters({
    required AppLocalizations localization,
    required bool isActive,
    VoidCallback? onPressed,
  }) =>
      FiltersButtonOrder(
          isActive: isActive,
          icon: Iconsax.filter_search,
          label: localization.filters,
          onPressed: onPressed);

  factory FiltersButtonOrder.from({
    required bool isActive,
    required AppLocalizations localization,
    VoidCallback? onPressed,
  }) =>
      FiltersButtonOrder(
          isActive: isActive,
          icon: Iconsax.search_favorite,
          label: localization.from,
          onPressed: onPressed);

  factory FiltersButtonOrder.status({
    required AppLocalizations localization,
    required bool isActive,
    VoidCallback? onPressed,
  }) =>
      FiltersButtonOrder(
          isActive: isActive,
          icon: Iconsax.money4,
          label: localization.status,
          onPressed: onPressed);

  factory FiltersButtonOrder.to({
    required AppLocalizations localization,
    required bool isActive,
    VoidCallback? onPressed,
  }) =>
      FiltersButtonOrder(
          isActive: isActive,
          icon: Iconsax.money4,
          label: localization.to,
          onPressed: onPressed);

  factory FiltersButtonOrder.clear({
    required AppLocalizations localization,
    required bool isActive,
    VoidCallback? onPressed,
  }) =>
      FiltersButtonOrder(
          isActive: isActive,
          icon: Iconsax.refresh_circle,
          label: localization.reset,
          onPressed: onPressed);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.accent1Shade1),
        iconColor: isActive ? AppColors.bgWhite : AppColors.accent1Shade1,
        backgroundColor: isActive ? AppColors.accent1Shade1 : AppColors.bgWhite,
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(icon),
          const ResponsiveGap.s4(),
          Text(
            label,
            style: context.responsiveTextTheme.current.bodySmall.copyWith(
              color: isActive ? AppColors.bgWhite : AppColors.accent1Shade1,
            ),
          ),
        ],
      ),
    );
  }
}
