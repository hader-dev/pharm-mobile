import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/filter_option_value.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class PaymentRadioInput extends StatelessWidget {
  final FormFieldValidator<PaymentMethods>? validator;

  const PaymentRadioInput({
    super.key,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<PaymentMethods>(
      validator: validator,
      initialValue:
          BlocProvider.of<CartCubit>(context).state.selectedPaymentMethod,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...PaymentMethods.values.map(
              (paymentMethod) => FilterOptionValueWidget(
                title: paymentMethod.translation(context.translation!),
                isSelected: field.value == paymentMethod,
                onSelected: () {
                  BlocProvider.of<CartCubit>(context)
                      .changePaymentMethod(paymentMethod);
                  field.didChange(paymentMethod); // notify FormField
                },
              ),
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 12),
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
