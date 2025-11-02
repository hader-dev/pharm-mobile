import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/widgets/filter_option_value.dart';
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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...PaymentMethods.values.map(
              (paymentMethod) => FilterOptionValueWidget(
                title: paymentMethod.translation(context.translation!),
                isSelected: field.value == paymentMethod,
                onSelected: () {
                  onPaymentMethodChanged(paymentMethod);

                  field.didChange(paymentMethod); // notify FormField
                },
              ),
            ),
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
