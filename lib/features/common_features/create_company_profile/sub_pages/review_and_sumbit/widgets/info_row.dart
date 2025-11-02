import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class InfoRow extends StatelessWidget {
  final IconData? icon;
  final String label;
  final String dataValue;
  final Axis contentDirection;

  const InfoRow(
      {super.key,
      this.icon,
      required this.label,
      this.dataValue = "",
      this.contentDirection = Axis.horizontal});

  @override
  Widget build(BuildContext context) {
    return contentDirection == Axis.horizontal
        ? Padding(
            padding: EdgeInsets.only(
                bottom: context.responsiveAppSizeTheme.current.p12),
            child: Row(
              children: [
                if (icon != null) Icon(icon, color: Colors.grey[700], size: 20),
                const ResponsiveGap.s8(),
                Text(label,
                    style: context.responsiveTextTheme.current.body3Medium
                        .copyWith(color: TextColors.ternary.color)),
                Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 2 / 6,
                  child: Tooltip(
                    message: dataValue.isEmpty
                        ? context.translation!.feedback_not_provided
                        : dataValue,
                    triggerMode: TooltipTriggerMode.tap,
                    child: Text(
                        dataValue.isEmpty
                            ? context.translation!.feedback_not_provided
                            : dataValue,
                        textAlign: TextAlign.end,
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
              Text(label,
                  style: context.responsiveTextTheme.current.body3Medium
                      .copyWith(color: TextColors.ternary.color)),
              const ResponsiveGap.s6(),
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
