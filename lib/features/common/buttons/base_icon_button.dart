import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class BaseIconButton extends StatelessWidget {
  final Widget icon;
  final Widget? label;
  final Color bgColor;
  final bool isBordered;
  final Color borderColor;
  final VoidCallback? onPressed;
  const BaseIconButton(
      {super.key,
      required this.icon,
      this.label,
      this.bgColor = Colors.transparent,
      this.isBordered = false,
      this.onPressed,
      this.borderColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          if (label != null) const ResponsiveGap.s4(),
          if (label != null) label!,
        ],
      ),
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: bgColor,
        padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(context.responsiveAppSizeTheme.current.r4),
          side: isBordered ? BorderSide(color: borderColor) : BorderSide.none,
        ),
      ),
    );
  }
}
