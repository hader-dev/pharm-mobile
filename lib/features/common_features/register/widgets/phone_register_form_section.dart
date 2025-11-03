import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../config/theme/colors_manager.dart';
import '../../../../utils/assets_strings.dart';
import '../../../../utils/enums.dart';
import '../../../common/text_fields/custom_text_field.dart';

class PhoneRegisterFormSection extends StatelessWidget {
  const PhoneRegisterFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: context.translation!.full_name,
          value: '',
          state: FieldState.normal,
          validationFunc: () {},
        ),
        const ResponsiveGap.s4(),
        CustomTextField(
          label: context.translation!.phone_mobile,
          value: '',
          prefixIcon: SvgPicture.asset(
            DrawableAssetStrings.algeriaFlagIcon,
          ),
          state: FieldState.normal,
          validationFunc: () {},
        ),
        ResponsiveGap.s4(),
        CustomTextField(
          label: context.translation!.password,
          value: '',
          onChanged: (value) {},
          isObscure: true,
          suffixIcon: Icon(
            Iconsax.eye,
            color: AppColors.accent1Shade1,
            size: context.responsiveAppSizeTheme.current.iconSize20,
          ),
          state: FieldState.normal,
          validationFunc: () {},
        ),
        ResponsiveGap.s4(),
        CustomTextField(
          label: context.translation!.confirm_password,
          value: '',
          onChanged: (value) {},
          isObscure: true,
          suffixIcon: Icon(
            Iconsax.eye,
            color: AppColors.accent1Shade1,
            size: context.responsiveAppSizeTheme.current.iconSize20,
          ),
          state: FieldState.normal,
          validationFunc: () {},
        ),
      ],
    );
  }
}
