import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';

class CustomAppBarV2 extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final Widget? leading;
  final List<Widget>? trailing;
  final double topPadding;
  final double bottomPadding;
  final double leftPadding;
  final double rightPadding;
  final Color bgColor;
  final double? titleWidthConstraiontRatio;
  final bool isExpanded;
  final bool useSpacer;
  final double? customPreferedSize;

  final double? height;
  final double? width;

  const CustomAppBarV2({
    super.key,
    required this.title,
    this.customPreferedSize,
    this.titleWidthConstraiontRatio = 0.5,
    this.leading,
    this.trailing,
    this.topPadding = 0,
    this.bottomPadding = 0,
    this.leftPadding = 0,
    this.rightPadding = 0,
    this.useSpacer = true,
    this.isExpanded = false,
    required this.bgColor,
    this.height,
    this.width,
  });

  const CustomAppBarV2.normal({
    super.key,
    required this.title,
    this.titleWidthConstraiontRatio = 0.5,
    this.leading,
    this.trailing,
    this.topPadding = 0,
    this.bottomPadding = 0,
    this.leftPadding = 0,
    this.rightPadding = 0,
    this.useSpacer = true,
    this.isExpanded = false,
    this.bgColor = Colors.white,
    this.height,
    this.customPreferedSize,
    this.width,
  });

  const CustomAppBarV2.expanded({
    super.key,
    required this.title,
    this.useSpacer = false,
    this.leading,
    this.trailing,
    this.topPadding = 0,
    this.bottomPadding = 0,
    this.leftPadding = 0,
    this.rightPadding = 0,
    required this.bgColor,
    this.height,
    this.width,
    this.customPreferedSize,
  })  : titleWidthConstraiontRatio = null,
        isExpanded = true;

  const CustomAppBarV2.alternate({
    super.key,
    required this.title,
    this.useSpacer = true,
    this.leading,
    this.trailing,
    this.topPadding = 0,
    this.bottomPadding = 0,
    this.leftPadding = 0,
    this.rightPadding = 0,
    this.titleWidthConstraiontRatio,
    this.isExpanded = false,
    this.bgColor = AppColors.accent1Shade2,
    this.height,
    this.width,
    this.customPreferedSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.only(
        top: topPadding == 0 ? MediaQuery.of(context).padding.top : topPadding,
        bottom: bottomPadding == 0 ? MediaQuery.of(context).padding.bottom : bottomPadding,
        left: leftPadding,
        right: rightPadding,
      ),
      color: bgColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        textBaseline: TextBaseline.alphabetic,
        mainAxisSize: MainAxisSize.max,
        children: [
          leading ?? const ResponsiveGap.s4(),
          if (isExpanded)
            Expanded(flex: 5, child: title)
          else
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width * (titleWidthConstraiontRatio ?? 0.5),
              ),
              child: title,
            ),
          if (useSpacer) const Spacer(),
          if (trailing != null)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [...trailing!],
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(customPreferedSize ?? kToolbarHeight);
}
