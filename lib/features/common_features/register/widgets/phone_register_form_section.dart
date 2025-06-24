import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../../../config/theme/colors_manager.dart';
import '../../../../utils/assets_strings.dart';

import '../../../../utils/constants.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/enums.dart';
import '../../../common/text_fields/custom_text_field.dart';

class PhoneRegisterFormSection extends StatelessWidget {
  const PhoneRegisterFormSection({super.key});

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
          label: 'Phone Number',
          value: '',
          prefixIcon: SvgPicture.asset(
            DrawableAssetStrings.algeriaFlagIcon,
          ),
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
      ],
    );
  }
}
