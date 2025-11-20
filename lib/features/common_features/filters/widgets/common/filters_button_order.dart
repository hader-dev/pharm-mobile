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
      {super.key, required this.isActive, required this.icon, required this.label, this.onPressed});

  factory FiltersButtonOrder.filters({
    required AppLocalizations localization,
    required bool isActive,
    VoidCallback? onPressed,
  }) =>
      FiltersButtonOrder(
          isActive: isActive, icon: Iconsax.filter_search, label: localization.filters, onPressed: onPressed);

  factory FiltersButtonOrder.from({
    required bool isActive,
    required AppLocalizations localization,
    VoidCallback? onPressed,
  }) =>
      FiltersButtonOrder(
          isActive: isActive, icon: Iconsax.calendar_add, label: localization.from, onPressed: onPressed);

  factory FiltersButtonOrder.status({
    required AppLocalizations localization,
    required bool isActive,
    VoidCallback? onPressed,
  }) =>
      FiltersButtonOrder(isActive: isActive, icon: Iconsax.status_up, label: localization.status, onPressed: onPressed);

  factory FiltersButtonOrder.to({
    required AppLocalizations localization,
    required bool isActive,
    VoidCallback? onPressed,
  }) =>
      FiltersButtonOrder(isActive: isActive, icon: Iconsax.calendar_tick, label: localization.to, onPressed: onPressed);

  factory FiltersButtonOrder.clear({
    required AppLocalizations localization,
    required bool isActive,
    VoidCallback? onPressed,
  }) =>
      FiltersButtonOrder(
          isActive: isActive, icon: Iconsax.refresh_circle, label: localization.reset, onPressed: onPressed);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onPressed,
        child: Container(
          margin: EdgeInsets.only(
              right: context.responsiveAppSizeTheme.current.p4, bottom: context.responsiveAppSizeTheme.current.p4),
          padding: EdgeInsets.symmetric(
              vertical: context.responsiveAppSizeTheme.current.p6,
              horizontal: context.responsiveAppSizeTheme.current.p12),
          decoration: BoxDecoration(
            border: Border.all(color: isActive ? AppColors.bgWhite : AppColors.accent1Shade1, width: .5),
            borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.commonWidgetsRadius),
          ),
          child: Row(
            children: [
              Icon(icon, color: isActive ? AppColors.bgWhite : AppColors.accent1Shade1),
              const ResponsiveGap.s4(),
              Text(
                label,
                style: context.responsiveTextTheme.current.bodySmall.copyWith(
                  color: isActive ? AppColors.bgWhite : AppColors.accent1Shade1,
                ),
              ),
            ],
          ),
        ));
  }
}
