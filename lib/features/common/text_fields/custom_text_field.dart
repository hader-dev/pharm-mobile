import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import '../../../config/theme/colors_manager.dart';
import '../../../config/theme/typoghrapy_manager.dart';
import '../../../utils/constants.dart';
import '../../../utils/enums.dart';
import '../../../utils/extensions/app_context_helper.dart';

class CustomTextField extends StatelessWidget {
  final GlobalKey<FormFieldState>? fieldKey;
  final String label;
  final String value;
  final FieldState state;
  final Function()? onTap;
  final Function(String val)? onSub;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function validationFunc;
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
  Color? fillColor;
  final double? width;
  final TextAlign textAlign;
  final Function(String?)? onChanged;
  final String? initValue;
  final int? minLines;
  final int maxLines;

  CustomTextField({
    super.key,
    this.fieldKey,
    this.label = '',
    this.value = '',
    this.state = FieldState.normal,
    this.onChanged,
    this.onTap,
    this.onSub,
    this.suffixIcon,
    this.prefixIcon,
    required this.validationFunc,
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

  Color _getEnabledBorderColor(BuildContext context) {
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
      default:
        return context.theme.primaryColor;
    }
  }

  Color _getFocusedBorderColor(BuildContext context) {
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

  Widget? _getSuffixIcon(FieldState state) {
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
        return Icon(FieldState.success.icon, color: FieldState.success.color.primary);
      case FieldState.warning:
        return Icon(FieldState.warning.icon, color: FieldState.warning.color.primary);
      case FieldState.error:
        return Icon(FieldState.error.icon, color: FieldState.error.color.primary);
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = state == FieldState.disabled;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppSizesManager.p4),
          child: Text(label, style: AppTypography.body3MediumStyle.copyWith(color: TextColors.ternary.color)),
        ),
        const Gap(AppSizesManager.s6),
        TextFormField(
          key: fieldKey,
          validator: (value) => validationFunc(value),
          cursorColor: context.theme.primaryColor,
          onChanged: onChanged,
          focusNode: fieldFocusNode,
          keyboardType: keyBoadType,
          textAlign: textAlign,
          readOnly: isReadOnly,
          onTap: onTap,
          enabled: isEnabled,
          errorBuilder: (context, errorText) {
            return Flexible(
              child: Text(
                errorText,
                style: AppTypography.bodyXSmallStyle.copyWith(color: Colors.red),
              ),
            );
          },
          inputFormatters: formatters,
          controller: controller,
          obscureText: isObscure,
          minLines: minLines,
          maxLines: maxLines,
          obscuringCharacter: '*',
          decoration: InputDecoration(
            isDense: true,
            filled: isFilled,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            contentPadding: EdgeInsets.all(AppSizesManager.p12),
            helper: Row(
              children: [
                _getSuffixIcon(state) ?? const SizedBox.shrink(),
                const Gap(AppSizesManager.s6),
                Text(
                  state.wordKey,
                  style: AppTypography.bodyXSmallStyle.copyWith(color: _getEnabledBorderColor(context)),
                ),
              ],
            ),
            fillColor: isDisabled
                ? AppColors.bgDisabled
                : state == FieldState.error
                    ? FieldState.error.color.ternary
                    : AppColors.bgWhite,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
              borderSide: BorderSide(color: _getEnabledBorderColor(context)),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
              borderSide: BorderSide(color: AppColors.bgDisabled),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
              borderSide: BorderSide(color: _getFocusedBorderColor(context)),
            ),
          ),
        ),
      ],
    );
  }
}
