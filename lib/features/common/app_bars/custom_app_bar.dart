import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final Widget? leading;
  final List<Widget>? trailing;
  final double topPadding;
  final double bottomPadding;
  final double leftPadding;
  final double rightPadding;
  final Color bgColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
    this.topPadding = 0,
    this.bottomPadding = 0,
    this.leftPadding = 0,
    this.rightPadding = 0,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(
          top: topPadding == 0 ? topPadding : MediaQuery.of(context).padding.top,
          bottom: bottomPadding == 0 ? bottomPadding : MediaQuery.of(context).padding.bottom,
          left: leftPadding,
          right: rightPadding),
      color: bgColor,
      width: double.maxFinite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        textBaseline: TextBaseline.alphabetic,
        children: [
          leading ?? const SizedBox(),
          const SizedBox(
            width: AppSizesManager.s4,
          ),
          ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 2 / 4), child: title),
          const Spacer(),
          if (trailing != null) Row(crossAxisAlignment: CrossAxisAlignment.center, children: [...trailing!]),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
