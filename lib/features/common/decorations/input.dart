import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

InputDecoration buildDropdownInputDecoration(
    String hintText, BuildContext context) {
  return InputDecoration(
      isDense: true,
      filled: true,
      contentPadding:
          EdgeInsets.all(context.responsiveAppSizeTheme.current.p12),
      fillColor: AppColors.bgWhite,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(
            context.responsiveAppSizeTheme.current.commonWidgetsRadius),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
            context.responsiveAppSizeTheme.current.commonWidgetsRadius),
        borderSide: BorderSide(color: AppColors.bgDisabled),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(
            context.responsiveAppSizeTheme.current.commonWidgetsRadius),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
            context.responsiveAppSizeTheme.current.commonWidgetsRadius),
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
            context.responsiveAppSizeTheme.current.commonWidgetsRadius),
        borderSide: BorderSide(color: FieldState.error.color.primary),
      ));
}
