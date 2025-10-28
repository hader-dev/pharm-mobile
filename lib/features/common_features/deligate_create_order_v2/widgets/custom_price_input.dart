import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hader_pharm_mobile/config/language_config/resources/app_localizations.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/validators.dart';

typedef OnPriceChanged = void Function(String price);

class CustomPriceFormField extends StatelessWidget {
  const CustomPriceFormField(
      {super.key,
      required this.translation,
      required this.customPriceController,
      required this.onPriceChanged,
      this.enabled = true,
      this.onEditComplete});

  final AppLocalizations translation;
  final TextEditingController customPriceController;
  final OnPriceChanged onPriceChanged;
  final VoidCallback? onEditComplete;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          translation.price,
          style: context.responsiveTextTheme.current.body3Medium.copyWith(
            color: TextColors.ternary.color,
          ),
        ),
        const ResponsiveGap.s4(),
        SizedBox(
          height: AppSizesManager.s32,
          child: TextFormField(
            enabled: enabled,
            controller: customPriceController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            style: context.responsiveTextTheme.current.body3Medium,
            decoration: InputDecoration(
              hintText: translation.custom_price,
              hintStyle: context.responsiveTextTheme.current.body3Medium,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSizesManager.s8, vertical: 0),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
                borderSide: BorderSide(color: StrokeColors.normal.color),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
                borderSide: BorderSide(color: StrokeColors.focused.color),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
                borderSide: BorderSide(color: StrokeColors.normal.color),
              ),
            ),
            onChanged: (value) => onPriceChanged(value),
            onEditingComplete: onEditComplete,
            validator: (value) => validateIsNumber(value, translation),
          ),
        ),
      ],
    );
  }
}
