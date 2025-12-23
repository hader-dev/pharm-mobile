import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart' show AppColors;
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

// ignore: must_be_immutable
class CustomChip extends StatelessWidget {
  final String label;
  final TextStyle? labelStyle;
  final Color labelColor;
  final Color color;
  IconData? icon;
  final Function()? onTap;
  bool isSelected;
  CustomChip(
      {super.key,
      required this.label,
      this.color = Colors.white,
      this.labelColor = Colors.black,
      this.icon,
      this.onTap,
      this.labelStyle,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            horizontal: context.responsiveAppSizeTheme.current.p6, vertical: context.responsiveAppSizeTheme.current.p4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.commonWidgetsRadius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (icon != null) ...[
              Icon(
                icon,
                color: isSelected ? AppColors.accent1Shade1 : labelColor,
                size: context.responsiveAppSizeTheme.current.iconSize20,
              ),
              const ResponsiveGap.s4(),
            ],
            Container(
              constraints: BoxConstraints(maxWidth: 90),
              child: Tooltip(
                  message: label,
                  child: Text(label,
                      softWrap: true,
                      textWidthBasis: TextWidthBasis.parent,
                      overflow: TextOverflow.ellipsis,
                      style: labelStyle?.copyWith(color: labelColor) ??
                          context.responsiveTextTheme.current.body3Medium.copyWith(color: labelColor))),
            ),
          ],
        ),
      ),
    );
  }
}
