import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class BaseIconButton extends StatefulWidget {
  final Widget icon;
  final Widget? label;
  final Color bgColor;
  final bool isBordered;
  final Color borderColor;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;

  const BaseIconButton({
    super.key,
    required this.icon,
    this.label,
    this.bgColor = Colors.transparent,
    this.isBordered = false,
    this.onPressed,
    this.onLongPressed,
    this.borderColor = Colors.transparent,
  });

  @override
  State<BaseIconButton> createState() => _BaseIconButtonState();
}

class _BaseIconButtonState extends State<BaseIconButton> {
  Timer? _timerInstance;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onLongPressStart: (_) {
        _timerInstance?.cancel();
        _timerInstance = Timer.periodic(
          const Duration(milliseconds: 235),
          (_) => widget.onLongPressed?.call(),
        );
      },
      onLongPressEnd: (_) {
        _timerInstance?.cancel();
        _timerInstance = null;
      },
      child: Container(
        padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
        decoration: BoxDecoration(
          color: widget.bgColor,
          borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.r4),
          border: widget.isBordered ? Border.all(color: widget.borderColor) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.icon,
            if (widget.label != null) const ResponsiveGap.s4(),
            if (widget.label != null) widget.label!,
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timerInstance?.cancel();
    super.dispose();
  }
}
