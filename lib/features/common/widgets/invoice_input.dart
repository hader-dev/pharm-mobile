import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/widgets/filter_option_value.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class InvoiceRadioInput extends StatelessWidget {
  final FormFieldValidator<InvoiceTypes>? validator;

  const InvoiceRadioInput({
    super.key,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<InvoiceTypes>(
      validator: validator,
      initialValue:
          BlocProvider.of<CartCubit>(context).state.selectedInvoiceType,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...InvoiceTypes.values.map(
              (invoiceType) => FilterOptionValueWidget(
                title: invoiceType.translation(context.translation!),
                isSelected: field.value == invoiceType,
                onSelected: () {
                  BlocProvider.of<CartCubit>(context)
                      .changeInvoiceType(invoiceType);
                  field.didChange(invoiceType);
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
