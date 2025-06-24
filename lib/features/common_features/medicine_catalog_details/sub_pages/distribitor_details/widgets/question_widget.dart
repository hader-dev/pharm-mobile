import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

class QuestionWidget extends StatefulWidget {
  final String question;
  final Widget answer;

  const QuestionWidget({super.key, required this.question, required this.answer});

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  final ValueNotifier _isExpanded = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizesManager.s16),
      child: ValueListenableBuilder(
        valueListenable: _isExpanded,
        builder: (context, value, child) => ExpansionTile(
          dense: true,
          trailing: Icon(_isExpanded.value ? Icons.minimize : Icons.add, color: AppColors.bgDarken2),
          iconColor: AppColors.accent1Shade1,
          maintainState: true,
          childrenPadding: const EdgeInsets.symmetric(vertical: AppSizesManager.p8, horizontal: AppSizesManager.p8),
          expandedAlignment: Alignment.centerLeft,
          tilePadding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p8),
          collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
              side: BorderSide(color: StrokeColors.normal.color)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
              side: BorderSide(color: StrokeColors.focused.color)),
          title: Text(widget.question, style: AppTypography.body3MediumStyle),
          onExpansionChanged: (value) {
            _isExpanded.value = value;
          },
          children: [widget.answer],
        ),
      ),
    );
  }
}
