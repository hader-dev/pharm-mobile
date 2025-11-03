import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hader_pharm_mobile/config/responsive/device_size.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/decorations/field.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class CompactCustomTextField extends StatelessWidget {
  final GlobalKey<FormFieldState>? fieldKey;
  final String label;
  final String value;
  final FieldState state;
  final Function()? onTap;
  final Function(String val)? onSub;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function? validationFunc;
  final String? hintText;

  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle;
  final TextEditingController? controller;
  final double horizontalPadding;
  final double verticalPadding;
  final bool isObscure;
  final bool isEnabled;
  final bool isReadOnly;
  final bool isBorderEnabled;
  final List<TextInputFormatter>? formatters;
  final TextInputType? keyBoadType;
  final FocusNode? fieldFocusNode;
  final bool isFilled;
  final Color? fillColor;
  final double? width;
  final TextAlign textAlign;
  final Function(String?)? onChanged;
  final String? initValue;
  final int? minLines;
  final int maxLines;

  const CompactCustomTextField({
    super.key,
    this.fillColor,
    this.fieldKey,
    this.label = '',
    this.value = '',
    this.state = FieldState.normal,
    this.onChanged,
    this.onTap,
    this.onSub,
    this.suffixIcon,
    this.prefixIcon,
    this.validationFunc,
    this.hintText,
    this.hintTextStyle,
    this.labelTextStyle,
    this.controller,
    this.horizontalPadding = 0,
    this.verticalPadding = 0,
    this.isObscure = false,
    this.isEnabled = true,
    this.isReadOnly = false,
    this.isBorderEnabled = true,
    this.formatters,
    this.keyBoadType,
    this.fieldFocusNode,
    this.isFilled = false,
    this.width,
    this.textAlign = TextAlign.start,
    this.initValue,
    this.minLines,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = state == FieldState.disabled;

    final fontSizeModifer =
        context.deviceSize.width <= DeviceSizes.largeMobile.width ? 1 : 2;

    return TextFormField(
      key: fieldKey,
      initialValue: initValue,
      validator: (value) => validationFunc?.call(value),
      cursorColor: context.theme.primaryColor,
      onChanged: onChanged,
      focusNode: fieldFocusNode,
      keyboardType: keyBoadType,
      textAlign: textAlign,
      readOnly: isReadOnly,
      onTap: onTap,
      enabled: isEnabled,
      inputFormatters: formatters,
      controller: controller,
      obscureText: isObscure,
      minLines: minLines,
      maxLines: maxLines,
      obscuringCharacter: '*',
      style: context.responsiveTextTheme.current.bodySmall.copyWith(
        fontSize: (context.responsiveTextTheme.current.bodySmall.fontSize! *
            fontSizeModifer),
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: context.responsiveTextTheme.current.body3Regular.copyWith(
            color: TextColors.ternary.color,
            fontSize: context.responsiveTextTheme.current.bodyXSmall.fontSize! *
                fontSizeModifer),
        isDense: true,
        filled: isFilled,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        contentPadding:
            EdgeInsets.all(context.responsiveAppSizeTheme.current.p12),
        fillColor: isDisabled
            ? AppColors.bgDisabled
            : state == FieldState.error
                ? FieldState.error.color.ternary
                : AppColors.bgWhite,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              context.responsiveAppSizeTheme.current.commonWidgetsRadius),
          borderSide: BorderSide(color: getEnabledBorderColor(context, state)),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              context.responsiveAppSizeTheme.current.commonWidgetsRadius),
          borderSide: BorderSide(color: AppColors.bgDisabled),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              context.responsiveAppSizeTheme.current.commonWidgetsRadius),
          borderSide: BorderSide(color: getFocusedBorderColor(context, state)),
        ),
      ),
    );
  }
}
