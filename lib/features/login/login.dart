import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/features/common/buttons/outlined/outlined_text_button.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

import '../../config/theme/colors_manager.dart';
import '../common/buttons/solid/primary_text_button.dart';
import 'widgets/login_form_section.dart';
import 'widgets/login_header_section.dart';
import 'widgets/other_login_options_section.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              LoginHeaderSection(),
              Gap(AppSizesManager.s32),
              LoginFormSection(),
              Gap(AppSizesManager.s32),
              OtherLoginOptionsSection(),
              Gap(AppSizesManager.s52),
              OutLinedTextButton(
                label: "Register (Don’t have an account?) ",
                labelColor: AppColors.accent1Shade1,
                isOutLined: true,
                onTap: () {},
                borderColor: AppColors.accent1Shade1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
