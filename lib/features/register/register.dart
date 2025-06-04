import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'widgets/email_register_form_section.dart';

import '../../config/theme/colors_manager.dart';
import '../../utils/constants.dart';
import '../common/buttons/outlined/outlined_text_button.dart';
import 'widgets/other_register_options_section.dart';
import 'widgets/phone_register_form_section.dart';
import 'widgets/register_header_section.dart';
import 'widgets/taps_section.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgWhite,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              RegisterHeaderSection(),
              Gap(AppSizesManager.s24),
              TabsSection(),
              Gap(AppSizesManager.s24),
              //   EmailRegisterFormSection(),
              PhoneRegisterFormSection(),
              Gap(AppSizesManager.s24),
              OtherRegisterOptionsSection(),
              Gap(AppSizesManager.s32),
              OutLinedTextButton(
                label: "Login (Already have an account!)",
                labelColor: AppColors.accent1Shade1,
                isOutLined: true,
                onTap: () {},
                borderColor: AppColors.accent1Shade1,
              ),
              Gap(AppSizesManager.s16),
            ],
          ),
        ),
      ),
    );
  }
}
