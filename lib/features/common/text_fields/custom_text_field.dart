import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/decorations/field.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class CustomTextField extends StatelessWidget {
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

  const CustomTextField({
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: AppSizesManager.p4),
            child: Text(label,
                style: context.responsiveTextTheme.current.body3Medium
                    .copyWith(color: TextColors.ternary.color)),
          ),
        if (label.isNotEmpty) const ResponsiveGap.s6(),
        TextFormField(
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
          errorBuilder: (context, errorText) {
            return Text(
              errorText,
              style: context.responsiveTextTheme.current.bodyXSmall
                  .copyWith(color: Colors.red),
            );
          },
          inputFormatters: formatters,
          controller: controller,
          obscureText: isObscure,
          minLines: minLines,
          maxLines: maxLines,
          textDirection: context.textDirection,
          obscuringCharacter: '*',
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: context.responsiveTextTheme.current.body3Regular
                  .copyWith(color: TextColors.ternary.color),
              isDense: true,
              filled: isFilled,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              contentPadding: EdgeInsets.all(AppSizesManager.p12),
              helper: Row(
                children: [
                  getSuffixIcon(state) ?? const SizedBox.shrink(),
                  const ResponsiveGap.s12(),
                  Text(
                    state.wordKey,
                    style: context.responsiveTextTheme.current.bodyXSmall
                        .copyWith(color: getEnabledBorderColor(context, state)),
                  ),
                ],
              ),
              fillColor: isDisabled
                  ? AppColors.bgDisabled
                  : state == FieldState.error
                      ? FieldState.error.color.ternary
                      : AppColors.bgWhite,
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
                borderSide:
                    BorderSide(color: getEnabledBorderColor(context, state)),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
                borderSide: BorderSide(color: AppColors.bgDisabled),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
                borderSide:
                    BorderSide(color: getFocusedBorderColor(context, state)),
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
              )),
        ),
      ],
    );
  }
}
