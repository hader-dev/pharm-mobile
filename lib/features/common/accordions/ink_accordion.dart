import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class InkAccordion extends StatefulWidget {
  final List<Widget> children;
  final Widget? title;
  final String? rawTitle;
  final bool isExpanded;

  const InkAccordion(
      {super.key,
      this.children = const [],
      this.title,
      this.rawTitle,
      this.isExpanded = false})
      : assert(title != null || rawTitle != null);

  @override
  State createState() => InkAccordionState();
}

class InkAccordionState extends State<InkAccordion> {
  late final ValueNotifier _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = ValueNotifier(widget.isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizesManager.p8, vertical: AppSizesManager.s8),
      child: ValueListenableBuilder(
        valueListenable: _isExpanded,
        builder: (context, value, child) => ExpansionTile(
          dense: true,
          initiallyExpanded: _isExpanded.value,
          trailing: Icon(_isExpanded.value
              ? Icons.minimize
              : Icons.keyboard_arrow_down_outlined),
          iconColor: AppColors.accent1Shade1,
          maintainState: true,
          childrenPadding: const EdgeInsets.symmetric(
              vertical: AppSizesManager.p8, horizontal: AppSizesManager.p8),
          expandedAlignment: Alignment.centerLeft,
          tilePadding:
              const EdgeInsets.symmetric(horizontal: AppSizesManager.p8),
          collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizesManager.r8),
              side: BorderSide(color: StrokeColors.normal.color)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizesManager.r8),
              side: BorderSide(color: StrokeColors.focused.color)),
          title: widget.title ??
              Text.rich(
                TextSpan(
                  text: widget.rawTitle,
                  style: context.responsiveTextTheme.current.bodySmall
                      .copyWith(
                          fontWeight: context.responsiveTextTheme.current
                              .appFont.appFontBold,
                          color: TextColors.primary.color),
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
          onExpansionChanged: (value) {
            _isExpanded.value = value;
          },
          children: widget.children,
        ),
      ),
    );
  }
}
