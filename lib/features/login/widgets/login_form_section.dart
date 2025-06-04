import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/enums.dart';
import '../../common/buttons/solid/primary_text_button.dart';
import '../../common/text_fields/custom_text_field.dart';

class LoginFormSection extends StatelessWidget {
  const LoginFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: 'Email or phone Number',
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
        Gap(AppSizesManager.s12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(),
            PrimaryTextButton(
              label: "Forgot Password?",
              onTap: () {},
              labelColor: AppColors.accent1Shade1,
            ),
          ],
        ),
        Gap(AppSizesManager.s24),
        PrimaryTextButton(
          label: "Login",
          onTap: () {},
          color: AppColors.accent1Shade1,
        ),
      ],
    );
  }
}
