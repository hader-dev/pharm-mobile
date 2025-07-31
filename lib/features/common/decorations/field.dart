import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

InputDecoration buildInputDecorationCustomFieldStyle(
    String hintText, FieldState state, BuildContext context,
    [bool isFilled = true, bool isDisabled = false]) {
  Color getEnabledBorderColor(BuildContext context) {
    switch (state) {
      case FieldState.success:
        return state.color.secondary;
      case FieldState.warning:
        return state.color.secondary;
      case FieldState.error:
        return Colors.red;
      case FieldState.disabled:
        return state.color.secondary;
      case FieldState.loading:
        return state.color.secondary;
      case FieldState.normal:
        return state.color.secondary;
    }
  }

  Color getFocusedBorderColor(BuildContext context) {
    switch (state) {
      case FieldState.success:
        return state.color.primary;
      case FieldState.warning:
        return state.color.primary;
      case FieldState.error:
        return Colors.red;
      case FieldState.disabled:
        return state.color.primary;

      default:
        return context.theme.primaryColor;
    }
  }

  return InputDecoration(
    hintText: hintText,
    hintStyle: AppTypography.body3RegularStyle
        .copyWith(color: TextColors.ternary.color),
    isDense: true,
    filled: isFilled,
    contentPadding: EdgeInsets.all(AppSizesManager.p12),
    fillColor: isDisabled
        ? AppColors.bgDisabled
        : state == FieldState.error
            ? FieldState.error.color.ternary
            : AppColors.bgWhite,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
      borderSide: BorderSide(color: getEnabledBorderColor(context)),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
      borderSide: BorderSide(color: AppColors.bgDisabled),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
      borderSide: BorderSide(color: getFocusedBorderColor(context)),
    ),
  );
}
