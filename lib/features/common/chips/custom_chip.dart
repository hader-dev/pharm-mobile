import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

// ignore: must_be_immutable
class CustomChip extends StatelessWidget {
  final String label;
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
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
            horizontal: AppSizesManager.p6, vertical: AppSizesManager.p4),
        decoration: BoxDecoration(
          color: color,
          borderRadius:
              BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
        ),
        child: Row(
          children: <Widget>[
            if (icon != null) ...[
              Icon(
                icon,
                color: labelColor,
                size: AppSizesManager.iconSize20,
              ),
              const ResponsiveGap.s4(),
            ],
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width / 2),
              child: Text(label,
                  softWrap: true,
                  textWidthBasis: TextWidthBasis.parent,
                  overflow: TextOverflow.ellipsis,
                  style: context.responsiveTextTheme.current.body3Medium
                      .copyWith(color: labelColor)),
            ),
          ],
        ),
      ),
    );
  }
}
