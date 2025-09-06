import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';

InputDecoration buildDropdownInputDecoration(
    String hintText, BuildContext context) {
  return InputDecoration(
      isDense: true,
      filled: true,
      contentPadding: EdgeInsets.all(AppSizesManager.p12),
      fillColor: AppColors.bgWhite,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius:
            BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
        borderSide: BorderSide(color: AppColors.bgDisabled),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius:
            BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
        borderSide: BorderSide(color: FieldState.error.color.primary),
      ));
}
