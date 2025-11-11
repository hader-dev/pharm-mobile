import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_icon_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

typedef OnQuantityChanged = void Function(String quantity);

class BaseQuantityController extends StatelessWidget {
  const BaseQuantityController({
    super.key,
    required this.label,
    required this.decrement,
    required this.increment,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.onQuantityChanged,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.axisDirection = Axis.horizontal,
    this.displayQuantityLabel = true,
    required this.quantityController,
  });

  const BaseQuantityController.vertical({
    super.key,
    required this.label,
    required this.decrement,
    required this.increment,
    required this.quantityController,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.onQuantityChanged,
    this.displayQuantityLabel = true,
  }) : axisDirection = Axis.vertical;

  final String label;
  final VoidCallback decrement;
  final TextEditingController quantityController;
  final VoidCallback increment;
  final CrossAxisAlignment crossAxisAlignment;
  final OnQuantityChanged? onQuantityChanged;
  final bool displayQuantityLabel;
  final Axis axisDirection;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final quantityField = Flexible(
      child: SizedBox(
        height: context.responsiveAppSizeTheme.current.buttonHeight,
        child: Form(
          child: TextFormField(
            cursorColor: AppColors.accentGreenShade1,
            controller: quantityController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (value) {
              final parsed = int.tryParse(value);
              if (value.isEmpty || parsed == null || parsed < 1) {
                quantityController.text = '1';
                quantityController.selection = TextSelection.fromPosition(
                  TextPosition(offset: quantityController.text.length),
                );
                onQuantityChanged?.call('1');
              } else {
                onQuantityChanged?.call(value);
              }
            },
            validator: (value) => value == null || value.isEmpty ? '' : null,
            style: context.responsiveTextTheme.current.body3Medium,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.all(context.responsiveAppSizeTheme.current.p12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  context.responsiveAppSizeTheme.current.commonWidgetsRadius,
                ),
                borderSide:
                    BorderSide(color: FieldState.normal.color.secondary),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  context.responsiveAppSizeTheme.current.commonWidgetsRadius,
                ),
                borderSide: BorderSide(color: AppColors.bgDisabled),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  context.responsiveAppSizeTheme.current.commonWidgetsRadius,
                ),
                borderSide: BorderSide(color: StrokeColors.focused.color),
              ),
            ),
          ),
        ),
      ),
    );

    final decrementButton = PrimaryIconButton(
      borderColor: StrokeColors.normal.color,
      isBordered: true,
      bgColor: Colors.transparent,
      onPressed: decrement,
      icon: const Icon(Iconsax.minus, color: Colors.black),
    );

    final incrementButton = PrimaryIconButton(
      borderColor: StrokeColors.normal.color,
      isBordered: true,
      bgColor: Colors.transparent,
      onPressed: increment,
      icon: Icon(Iconsax.add, color: Colors.black),
    );

    Widget controlLayout;

    if (axisDirection == Axis.horizontal) {
      controlLayout = Row(
        children: [
          decrementButton,
          const ResponsiveGap.s12(),
          quantityField,
          const ResponsiveGap.s12(),
          incrementButton,
        ],
      );
    } else {
      controlLayout = Column(
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: MainAxisSize.max,
        children: [
          incrementButton,
          quantityField,
          decrementButton,
        ],
      );
    }

    if (displayQuantityLabel) {
      return Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(
            label,
            style: context.responsiveTextTheme.current.body3Medium.copyWith(
              color: TextColors.ternary.color,
            ),
          ),
          controlLayout,
        ],
      );
    }

    return controlLayout;
  }
}
