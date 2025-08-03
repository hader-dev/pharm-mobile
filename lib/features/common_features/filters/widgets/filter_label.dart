import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';


typedef OnSelectedCallback = void Function(String value, bool selected);

class FilterLabel extends StatelessWidget {
  const FilterLabel({super.key, required this.label,  this.isSelected = false,  this.onSelected});
  final String label;
  final bool isSelected;
  final OnSelectedCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Checkbox(value: isSelected, onChanged: (v) => onSelected?.call(label, v!)),
          Expanded(
            child: Text(
              label,
              style: AppTypography.bodySmallStyle.copyWith(
                  fontWeight: AppTypography.appFontBold,
                  color: TextColors.primary.color),
            ),
          ),
        ],
      ),
    );
  }
}
