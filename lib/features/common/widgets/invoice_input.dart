import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/widgets/payment_input.dart'
    show buildCustomRadio;
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

typedef OnInvoiceTypeChanged = void Function(InvoiceTypes invoiceType);

class InvoiceRadioInput extends StatelessWidget {
  final FormFieldValidator<InvoiceTypes>? validator;
  final OnInvoiceTypeChanged onInvoiceTypeChanged;
  final InvoiceTypes initialValue;

  const InvoiceRadioInput(
      {super.key,
      this.validator,
      required this.onInvoiceTypeChanged,
      required this.initialValue});

  @override
  Widget build(BuildContext context) {
    return FormField<InvoiceTypes>(
      validator: validator,
      initialValue: initialValue,
      builder: (field) {
        return Wrap(
          spacing: context.responsiveAppSizeTheme.current.s4,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            ...InvoiceTypes.values.map((invoiceType) => buildCustomRadio(
                  context,
                  title: invoiceType.translation(context.translation!),
                  isSelected: field.value == invoiceType,
                  onSelected: () {
                    onInvoiceTypeChanged(invoiceType);
                    field.didChange(invoiceType);
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
