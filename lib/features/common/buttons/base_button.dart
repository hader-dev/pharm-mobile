import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class BaseButton extends StatelessWidget {
  final Function? onTap;
  final bool isLoading;
  final double padding;
  final double height;
  final double minWidth;
  final double radiusValue;
  final String label;
  final Color? color;
  final Color loadingColor;
  final Color? labelColor;
  final bool isRectangular;
  final bool isOutLined;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final Color? borderColor;
  final Color? spalshColor;
  final TextOverflow? textOverflow;
  final double? maxWidth;
  final TextStyle? labelTextStyle;

  const BaseButton({
    super.key,
    this.maxWidth,
    this.textOverflow = TextOverflow.ellipsis,
    this.onTap,
    this.isLoading = false,
    this.padding = AppSizesManager.p10,
    required this.label,
    this.color,
    this.labelColor = Colors.white,
    this.height = AppSizesManager.buttonHeight,
    this.loadingColor = Colors.white,
    this.minWidth = 100,
    this.radiusValue = AppSizesManager.commonWidgetsRadius,
    this.isRectangular = true,
    this.isOutLined = false,
    this.borderColor,
    this.leadingIcon,
    this.spalshColor,
    this.trailingIcon,
    this.labelTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      padding: EdgeInsets.all(padding),
      splashColor: spalshColor ?? Colors.transparent,
      elevation: 0,
      disabledColor: AppColors.bgDisabled,
      shape:
          getButtonShape(isRectangular, isOutLined, borderColor: borderColor),
      disabledElevation: 0,
      height: height,
      minWidth: minWidth,
      highlightElevation: 0,
      highlightColor: AppColors.bgWhite.withValues(alpha: 200),
      onPressed: onTap == null
          ? null
          : isLoading
              ? () {}
              : () => onTap!(),
      child: isLoading
          ? Center(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: SizedBox(
                  width: 15,
                  height: 15,
                  child: CircularProgressIndicator(
                    color: loadingColor,
                    strokeWidth: 2.0,
                  ),
                ),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (leadingIcon != null)
                  Row(
                    children: [
                      Icon(
                        leadingIcon,
                        color: onTap == null ? Colors.grey : labelColor,
                        size: AppSizesManager.s16,
                      ),
                      const ResponsiveGap.s8(),
                    ],
                  ),
                ConstrainedBox(
                  constraints:
                      BoxConstraints(maxWidth: maxWidth ?? double.infinity),
                  child: Text(
                    label,
                    style: labelTextStyle ??
                        context.responsiveTextTheme.current.headLine4Medium
                            .copyWith(
                          color: onTap == null ? Colors.grey : labelColor,
                        ),
                    overflow: textOverflow,
                  ),
                ),
                if (trailingIcon != null)
                  Row(
                    children: [
                      const ResponsiveGap.s8(),
                      Icon(
                        trailingIcon,
                        color: onTap == null ? Colors.grey : labelColor,
                        size: AppSizesManager.s16,
                      ),
                    ],
                  ),
              ],
            ),
    );
  }

  dynamic getButtonShape(bool isRectangular, bool isOutLined,
      {Color? borderColor}) {
    if (isRectangular) {
      return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusValue),
        side: isOutLined
            ? BorderSide(color: borderColor ?? Colors.black, width: .6)
            : BorderSide.none,
      );
    } else {
      return const CircleBorder();
    }
  }
}
