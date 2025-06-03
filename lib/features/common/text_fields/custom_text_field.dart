import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../utils/constants.dart';

// ignore: must_be_immutable
class CommonTextField extends StatelessWidget {
  final Function()? onTap;
  final Function(String val)? onSub;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function validationFunc;
  final String? hintText;
  final String? label;

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
  Color? fillColor;
  final double? width;
  final TextAlign textAlign;
  final Function(String?)? onChanged;
  final String? initValue;
  final int? minLines;
  final int maxLines;
  CommonTextField({
    super.key,
    this.controller,
    this.hintText,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    required this.validationFunc,
    this.label,
    this.horizontalPadding = 0,
    this.verticalPadding = 0,
    this.hintTextStyle,
    this.labelTextStyle,
    this.isObscure = false,
    this.isEnabled = true,
    this.formatters,
    this.isReadOnly = false,
    this.width = double.maxFinite,
    this.keyBoadType,
    this.fieldFocusNode,
    this.textAlign = TextAlign.start,
    this.isFilled = true,
    this.fillColor,
    this.onSub,
    this.onChanged,
    this.initValue,
    this.isBorderEnabled = false,
    this.minLines,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
        child: TextFormField(
          cursorColor: context.theme.primaryColor,
          initialValue: initValue,
          onChanged: onChanged,
          onFieldSubmitted: onSub,
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
          validator: (val) {
            return validationFunc(val);
          },
          decoration: InputDecoration(
            filled: isFilled,
            fillColor: fillColor ?? context.theme.canvasColor,
            contentPadding: const EdgeInsets.symmetric(
              vertical: AppSizesManager.p8,
              horizontal: AppSizesManager.p8,
            ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizesManager.r12),
              // borderSide:
              //     BorderSide(color: isBorderEnabled ? AppColorsPallette.lightAccentsColors[3] : Colors.transparent),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizesManager.r12),
              //borderSide: BorderSide(color: AppColorsPallette.lightAccentsColors[1]),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizesManager.r12),
              borderSide: BorderSide(color: context.theme.primaryColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizesManager.r12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizesManager.r12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            hintStyle: hintTextStyle,
            labelStyle: labelTextStyle,
            alignLabelWithHint: true,
            hintText: hintText,
            labelText: label,
          ),
          style: context.theme.textTheme.displaySmall!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
