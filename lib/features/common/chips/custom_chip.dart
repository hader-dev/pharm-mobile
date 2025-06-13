import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p6, vertical: AppSizesManager.p4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
        ),
        child: Row(
          children: <Widget>[
            if (icon != null) ...[
              Icon(
                icon,
                color: labelColor,
                size: AppSizesManager.iconSize20,
              ),
              const Gap(AppSizesManager.s4),
            ],
            Text(label,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.body2MediumStyle.copyWith(color: labelColor)),
          ],
        ),
      ),
    );
  }
}
