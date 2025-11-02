import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class QuestionWidget extends StatefulWidget {
  final String question;
  final Widget answer;

  const QuestionWidget(
      {super.key, required this.question, required this.answer});

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  final ValueNotifier _isExpanded = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.responsiveAppSizeTheme.current.s16),
      child: ValueListenableBuilder(
        valueListenable: _isExpanded,
        builder: (context, value, child) => ExpansionTile(
          dense: true,
          trailing: Icon(_isExpanded.value ? Icons.minimize : Icons.add,
              color: AppColors.bgDarken2),
          iconColor: AppColors.accent1Shade1,
          maintainState: true,
          childrenPadding: EdgeInsets.symmetric(
              vertical: context.responsiveAppSizeTheme.current.p8,
              horizontal: context.responsiveAppSizeTheme.current.p8),
          expandedAlignment: Alignment.centerLeft,
          tilePadding: EdgeInsets.symmetric(
              horizontal: context.responsiveAppSizeTheme.current.p8),
          collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  context.responsiveAppSizeTheme.current.commonWidgetsRadius),
              side: BorderSide(color: StrokeColors.normal.color)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  context.responsiveAppSizeTheme.current.commonWidgetsRadius),
              side: BorderSide(color: StrokeColors.focused.color)),
          title: Text(widget.question,
              style: context.responsiveTextTheme.current.body3Medium),
          onExpansionChanged: (value) {
            _isExpanded.value = value;
          },
          children: [widget.answer],
        ),
      ),
    );
  }
}
