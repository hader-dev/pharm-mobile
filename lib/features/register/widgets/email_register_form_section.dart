import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

import '../../../config/theme/colors_manager.dart';
import '../../../utils/constants.dart';
import '../../../utils/enums.dart';
import '../../common/buttons/solid/primary_text_button.dart';
import '../../common/text_fields/custom_text_field.dart';

class EmailRegisterFormSection extends StatelessWidget {
  const EmailRegisterFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: 'Full Name',
          value: '',
          state: FieldState.normal,
          validationFunc: () {},
        ),
        Gap(AppSizesManager.s4),
        CustomTextField(
          label: 'Email',
          value: '',
          state: FieldState.normal,
          validationFunc: () {},
        ),
        Gap(AppSizesManager.s4),
        CustomTextField(
          label: 'Password',
          value: '',
          onChanged: (value) {},
          isObscure: true,
          suffixIcon: Icon(Iconsax.eye, color: AppColors.accent1Shade1),
          state: FieldState.normal,
          validationFunc: () {},
        ),
        Gap(AppSizesManager.s4),
        CustomTextField(
          label: 'Confirme Password',
          value: '',
          onChanged: (value) {},
          isObscure: true,
          suffixIcon: Icon(Iconsax.eye, color: AppColors.accent1Shade1),
          state: FieldState.normal,
          validationFunc: () {},
        ),
        Gap(AppSizesManager.s16),
        PrimaryTextButton(
          label: "Sign up",
          onTap: () {},
          color: AppColors.accent1Shade1,
        ),
      ],
    );
  }
}
