import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

typedef OnSelectedCallback = void Function(String value, bool selected);

class FilterLabel extends StatelessWidget {
  const FilterLabel(
      {super.key,
      required this.label,
      this.isSelected = false,
      this.onSelected});
  final String label;
  final bool isSelected;
  final OnSelectedCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelected?.call(label, !isSelected),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Checkbox(
                value: isSelected,
                onChanged: (v) => onSelected?.call(label, v!),
              ),
              const ResponsiveGap.s8(),
              Expanded(
                child: Text(
                  label,
                  style: context.responsiveTextTheme.current.bodySmall.copyWith(
                      fontWeight: context
                          .responsiveTextTheme.current.appFont.appFontBold,
                      color: TextColors.primary.color),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
