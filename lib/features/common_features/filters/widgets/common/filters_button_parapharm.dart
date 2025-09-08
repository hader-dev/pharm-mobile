import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/language_config/resources/app_localizations.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class FiltersButtonParapharm extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  const FiltersButtonParapharm(
      {super.key, required this.icon, required this.label, this.onPressed});

  factory FiltersButtonParapharm.filters({
    required AppLocalizations localization,
    VoidCallback? onPressed,
  }) =>
      FiltersButtonParapharm(
          icon: Iconsax.filter_search,
          label: localization.filters,
          onPressed: onPressed);

  factory FiltersButtonParapharm.name({
    required AppLocalizations localization,
    VoidCallback? onPressed,
  }) =>
      FiltersButtonParapharm(
          icon: Iconsax.search_favorite,
          label: localization.filter_items_name,
          onPressed: onPressed);

  factory FiltersButtonParapharm.price({
    required AppLocalizations localization,
    VoidCallback? onPressed,
  }) =>
      FiltersButtonParapharm(
          icon: Iconsax.money4,
          label: localization.price,
          onPressed: onPressed);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.accent1Shade1),
        iconColor: AppColors.accent1Shade1,
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(icon),
          const ResponsiveGap.s4(),
          Text(
            label,
            style: context.responsiveTextTheme.current.bodySmall
                .copyWith(color: AppColors.accent1Shade1),
          ),
        ],
      ),
    );
  }
}
