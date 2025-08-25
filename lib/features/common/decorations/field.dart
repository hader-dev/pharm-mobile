import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

Widget? getSuffixIcon(FieldState state) {
  switch (state) {
    case FieldState.loading:
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizesManager.s4),
        child: SizedBox(
          width: AppSizesManager.s12,
          height: AppSizesManager.s12,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    case FieldState.success:
      return Icon(FieldState.success.icon,
          color: FieldState.success.color.primary);
    case FieldState.warning:
      return Icon(FieldState.warning.icon,
          color: FieldState.warning.color.primary);
    case FieldState.error:
      return Icon(FieldState.error.icon, color: FieldState.error.color.primary);
    default:
      return null;
  }
}

Color getEnabledBorderColor(BuildContext context, FieldState state) {
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

Color getFocusedBorderColor(BuildContext context, FieldState state) {
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

InputDecoration buildInputDecorationCustomFieldStyle(
    String hintText, FieldState state, BuildContext context,
    [bool isFilled = true, bool isDisabled = false]) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: context.responsiveTextTheme.current.body3Regular
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
        borderRadius:
            BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
        borderSide: BorderSide(color: getEnabledBorderColor(context, state)),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
        borderSide: BorderSide(color: AppColors.bgDisabled),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
        borderSide: BorderSide(color: getFocusedBorderColor(context, state)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
        borderSide: BorderSide(color: FieldState.error.color.primary),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
        borderSide: BorderSide(color: FieldState.error.color.primary),
      ));
}
