import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';

import '../../../config/theme/colors_manager.dart';
import '../../../utils/constants.dart';

class BaseButton extends StatelessWidget {
  final Function? onTap;
  final bool isLoading;
  final double padding;
  double height;
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
  Color? borderColor;

  BaseButton({
    super.key,
    this.onTap,
    this.isLoading = false,
    this.padding = AppSizesManager.p8,
    required this.label,
    this.color,
    this.labelColor = Colors.white,
    this.height = AppSizesManager.buttonHeight,
    this.loadingColor = Colors.white,
    this.minWidth = 100,
    this.radiusValue = AppSizesManager.r4,
    this.isRectangular = true,
    this.isOutLined = false,
    this.borderColor,
    this.leadingIcon,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      splashColor: Colors.transparent,
      elevation: 0,
      disabledColor: AppColors.bgDisabled,
      shape: getButtonShape(isRectangular, isOutLined, borderColor: borderColor),
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
                      const Gap(AppSizesManager.s8),
                    ],
                  ),
                Text(
                  label,
                  style: AppTypography.headLine4MediumStyle.copyWith(
                    color: onTap == null ? Colors.grey : labelColor,
                  ),
                ),
                if (trailingIcon != null)
                  Row(
                    children: [
                      const Gap(AppSizesManager.s8),
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

  dynamic getButtonShape(bool isRectangular, bool isOutLined, {Color? borderColor}) {
    if (isRectangular) {
      return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusValue),
        side: isOutLined ? BorderSide(color: borderColor ?? Colors.black, width: .6) : BorderSide.none,
      );
    } else {
      return const CircleBorder();
    }
  }
}
