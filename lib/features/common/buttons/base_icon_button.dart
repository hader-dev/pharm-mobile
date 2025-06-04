import 'package:flutter/material.dart';

import 'package:hader_pharm_mobile/utils/constants.dart';

class BaseIconButton extends StatelessWidget {
  final Widget icon;
  final Color bgColor;
  final bool isBordered;
  final Color borderColor;
  final VoidCallback? onPressed;
  const BaseIconButton(
      {super.key,
      required this.icon,
      this.bgColor = Colors.transparent,
      this.isBordered = false,
      this.onPressed,
      this.borderColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: bgColor,
        padding: EdgeInsets.all(AppSizesManager.p8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizesManager.r4),
          side: isBordered ? BorderSide(color: borderColor) : BorderSide.none,
        ),
      ),
    );
  }
}
