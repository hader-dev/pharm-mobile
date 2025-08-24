import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

InputDecoration buildDropdownInputDecoration(
    String hintText, BuildContext context) {
  return InputDecoration(
    isDense: true,
    filled: true,
    contentPadding: EdgeInsets.all(AppSizesManager.p12),
    fillColor: AppColors.bgWhite,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
      borderSide: BorderSide(color: AppColors.bgDisabled),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
      borderSide: BorderSide(color: Colors.red),
    ),
  );
}
