import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/enums.dart';
import '../../../common/text_fields/custom_text_field.dart';

class GeneralInformationPage extends StatelessWidget {
  const GeneralInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CustomTextField(
              label: 'Company Name',
              value: '',
              state: FieldState.normal,
              validationFunc: () {},
            ),
            CustomTextField(
              label: 'Wilaya (Province)',
              value: '',
              state: FieldState.normal,
              validationFunc: () {},
            ),
            CustomTextField(
              label: 'City/Commune',
              value: '',
              state: FieldState.normal,
              validationFunc: () {},
            ),
            CustomTextField(
              label: 'Full Address',
              value: '',
              state: FieldState.normal,
              validationFunc: () {},
            ),
            CustomTextField(
              label: 'Website (Optional)',
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
