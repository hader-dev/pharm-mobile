import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class InfoRow extends StatelessWidget {
  final IconData? icon;
  final String? label;
  final String dataValue;
  final Axis contentDirection;
  final Color iconColor;

  const InfoRow(
      {super.key,
      this.icon,
      this.label,
      this.dataValue = "",
      this.iconColor = Colors.grey,
      this.contentDirection = Axis.horizontal});

  @override
  Widget build(BuildContext context) {
    return contentDirection == Axis.horizontal
        ? Padding(
            padding: EdgeInsets.only(
                bottom: context.responsiveAppSizeTheme.current.p12),
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, color: iconColor, size: 20),
                  const ResponsiveGap.s8(),
                ],
                if (label != null) ...[
                  Text(label!,
                      style: context.responsiveTextTheme.current.body3Medium
                          .copyWith(color: TextColors.ternary.color)),
                  const Spacer(),
                ],
                Expanded(
                  child: Tooltip(
                    message: dataValue.isEmpty
                        ? context.translation!.feedback_not_provided
                        : dataValue,
                    triggerMode: TooltipTriggerMode.longPress,
                    child: Text(
                        dataValue.isEmpty
                            ? context.translation!.feedback_not_provided
                            : dataValue,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: context.responsiveTextTheme.current.body3Medium),
                  ),
                ),
              ],
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (label != null) ...[
                Text(label!,
                    style: context.responsiveTextTheme.current.body3Medium
                        .copyWith(color: TextColors.ternary.color)),
                const ResponsiveGap.s6(),
              ],
              Tooltip(
                message: dataValue.isEmpty
                    ? context.translation!.feedback_not_provided
                    : dataValue,
                triggerMode: TooltipTriggerMode.tap,
                child: Text(
                    dataValue.isEmpty
                        ? context.translation!.feedback_not_provided
                        : dataValue,
                    textAlign: TextAlign.start, // Changed from end to start
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: context.responsiveTextTheme.current.body3Medium),
              ),
            ],
          );
  }
}
