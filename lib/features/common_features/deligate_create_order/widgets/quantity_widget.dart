import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hader_pharm_mobile/config/language_config/resources/app_localizations.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_icon_button.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class DeligateOrderItemQuantity extends StatelessWidget {
  const DeligateOrderItemQuantity(
      {super.key,
      required this.translation,
      required this.onIncrement,
      required this.onDecrement,
      required this.quantityController,
      this.onChanged,
      this.onEditComplete});

  final AppLocalizations translation;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback? onEditComplete;
  final TextEditingController quantityController;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                translation.quantity,
                style: context.responsiveTextTheme.current.body3Medium.copyWith(
                  color: TextColors.ternary.color,
                ),
              ),
              const SizedBox(height: AppSizesManager.s4),
              Row(
                children: [
                  SizedBox(
                    width: AppSizesManager.s32,
                    height: AppSizesManager.s32,
                    child: PrimaryIconButton(
                      borderColor: StrokeColors.normal.color,
                      isBordered: true,
                      bgColor: Colors.transparent,
                      onPressed: onDecrement,
                      icon: Icon(
                        Iconsax.minus,
                        size: AppSizesManager.iconSize16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSizesManager.s8),
                  Expanded(
                    child: SizedBox(
                      height: AppSizesManager.s32,
                      child: TextFormField(
                        controller: quantityController,
                        cursorColor: AppColors.accentGreenShade1,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) =>
                            value == null || value.isEmpty ? '' : null,
                        onEditingComplete: onEditComplete,
                        onChanged: onChanged,
                        style: context.responsiveTextTheme.current.body3Medium,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: AppSizesManager.s8, vertical: 0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                AppSizesManager.commonWidgetsRadius),
                            borderSide:
                                BorderSide(color: StrokeColors.normal.color),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                AppSizesManager.commonWidgetsRadius),
                            borderSide:
                                BorderSide(color: StrokeColors.focused.color),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSizesManager.s8),
                  SizedBox(
                    width: AppSizesManager.s32,
                    height: AppSizesManager.s32,
                    child: PrimaryIconButton(
                      borderColor: StrokeColors.normal.color,
                      isBordered: true,
                      bgColor: Colors.transparent,
                      onPressed: onIncrement,
                      icon: Icon(
                        Iconsax.add,
                        size: AppSizesManager.iconSize16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
