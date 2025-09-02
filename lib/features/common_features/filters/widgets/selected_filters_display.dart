import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/chips/custom_chip.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

class SelectedFiltersDisplay extends StatelessWidget {
  final List<String> selectedFilters;
  final Function(String) onRemoveFilter;

  const SelectedFiltersDisplay({
    super.key,
    required this.selectedFilters,
    required this.onRemoveFilter,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedFilters.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ResponsiveGap.s8(),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSizesManager.p8),
          decoration: BoxDecoration(
            color: AppColors.bgDarken.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: AppColors.accent1Shade1.withValues(alpha: 0.2)),
          ),
          child: SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: selectedFilters.length,
              separatorBuilder: (context, index) => const ResponsiveGap.s4(),
              itemBuilder: (context, index) {
                final filter = selectedFilters[index];
                return Transform.scale(
                  scale: 0.85,
                  child: CustomChip(
                    label: filter,
                    color: AppColors.accent1Shade1.withValues(alpha: 0.1),
                    labelColor: AppColors.accent1Shade1,
                    icon: Icons.close,
                    onTap: () => onRemoveFilter(filter),
                  ),
                );
              },
            ),
          ),
        ),
        const ResponsiveGap.s8(),
      ],
    );
  }
}
