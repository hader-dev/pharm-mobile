import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/enums.dart';
import '../../../common/text_fields/custom_text_field.dart';

class LegalInformationPage extends StatelessWidget {
  const LegalInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CustomTextField(
              label: 'NIF (Tax Identification Number)',
              value: '',
              state: FieldState.normal,
              validationFunc: () {},
            ),
            CustomTextField(
              label: 'NIS (Static Indentification Number)',
              value: '',
              state: FieldState.normal,
              validationFunc: () {},
            ),
            CustomTextField(
              label: 'Commercial Registration Number (RC)',
              value: '',
              state: FieldState.normal,
              validationFunc: () {},
            ),
            CustomTextField(
              label: 'Credit Limit (numeric)',
              value: '',
              state: FieldState.normal,
              validationFunc: () {},
            ),
            CustomTextField(
              label: 'AI (text)',
              value: '',
              state: FieldState.normal,
              validationFunc: () {},
            ),
          ],
        ),
      ),
    );
  }
}
