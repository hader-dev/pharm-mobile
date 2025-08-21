import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class InkAccordionItem extends StatelessWidget {
  final Widget? title;
  final String? rawTitle;
  final VoidCallback? onTap;
  final String? rawSubtitle;
  final Widget? subtitle;

  const InkAccordionItem({
    super.key,
    this.title,
    this.onTap,
    this.rawTitle,
    this.rawSubtitle,
    this.subtitle,
  }) : assert(title != null || rawTitle != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizesManager.p4, vertical: AppSizesManager.s4),
      child: ListTile(
        dense: true,
        trailing: Icon(Icons.keyboard_arrow_right_outlined),
        iconColor: AppColors.accent1Shade1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizesManager.r8),
            side: BorderSide(color: StrokeColors.focused.color)),
        title: title ??
            Text.rich(
              TextSpan(
                text: rawTitle,
                style: context.responsiveTextTheme.current.bodySmall.copyWith(
                    fontWeight:
                        context.responsiveTextTheme.current.appFont.appFontBold,
                    color: TextColors.primary.color),
              ),
            ),
        subtitle: subtitle ??
            Text.rich(
              TextSpan(
                text: rawSubtitle ?? context.translation!.any,
                style: context.responsiveTextTheme.current.bodySmall.copyWith(
                    fontWeight:
                        context.responsiveTextTheme.current.appFont.appFontBold,
                    color: TextColors.ternary.color),
              ),
            ),
        onTap: onTap,
      ),
    );
  }
}
