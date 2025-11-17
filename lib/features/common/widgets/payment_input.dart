import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart'
    show AppColors, StrokeColors;
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

typedef OnPaymentMethodChanged = void Function(PaymentMethods paymentMethod);

class PaymentRadioInput extends StatelessWidget {
  final FormFieldValidator<PaymentMethods>? validator;
  final OnPaymentMethodChanged onPaymentMethodChanged;
  final PaymentMethods initialValue;

  const PaymentRadioInput({
    super.key,
    this.validator,
    required this.onPaymentMethodChanged,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<PaymentMethods>(
      validator: validator,
      initialValue: initialValue,
      builder: (field) {
        return Wrap(
          spacing: context.responsiveAppSizeTheme.current.s4,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            ...PaymentMethods.values.map((paymentMethod) => buildCustomRadio(
                  context,
                  title: paymentMethod.translation(context.translation!),
                  isSelected: field.value == paymentMethod,
                  onSelected: () {
                    onPaymentMethodChanged(paymentMethod);

                    field.didChange(paymentMethod); // notify FormField
                  },
                )),
            if (field.hasError)
              Padding(
                padding: EdgeInsets.only(top: 4, left: 12),
                child: Text(
                  field.errorText ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.red),
                ),
              ),
          ],
        );
      },
    );
  }
}

Widget buildCustomRadio(BuildContext context,
    {String title = 'Default',
    bool isSelected = false,
    required VoidCallback onSelected}) {
  return InkWell(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: onSelected,
    child: Padding(
      padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          dashPattern: [3, 3],
          strokeWidth: .8,
          radius: Radius.circular(
              context.responsiveAppSizeTheme.current.commonWidgetsRadius),
          color: isSelected ? AppColors.accent1Shade1 : Colors.grey.shade400,
          padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: isSelected
                          ? AppColors.accent1Shade1
                          : StrokeColors.normal.color,
                      width: 1),
                  shape: BoxShape.circle),
              child: Center(
                child: Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.accent1Shade1
                            : Colors.transparent,
                        shape: BoxShape.circle)),
              ),
            ),
            ResponsiveGap.s6(),
            Text(
              title,
              style: isSelected
                  ? context.responsiveTextTheme.current.body3Medium
                  : context.responsiveTextTheme.current.body3Regular,
            ),
          ],
        ),
      ),
    ),
  );
}
