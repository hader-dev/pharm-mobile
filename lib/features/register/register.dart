import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/features/register/cubit/register_cubit.dart';

import '../../config/theme/colors_manager.dart';
import '../../utils/constants.dart';
import '../common/buttons/outlined/outlined_text_button.dart';
import 'widgets/email_register_form_section.dart';
import 'widgets/other_register_options_section.dart';

import 'widgets/phone_register_form_section.dart';
import 'widgets/register_header_section.dart';
import 'widgets/taps_section.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(userManager: getItInstance.get<UserManager>()),
      child: SafeArea(
        child: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccuss) {
              GoRouter.of(context).goNamed(RoutingManager.checkEmailScreen, extra: state.email);
            }
          },
          child: Scaffold(
            backgroundColor: AppColors.bgWhite,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
              child: BlocBuilder<RegisterCubit, RegisterState>(
                builder: (context, state) {
                  return ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      RegisterHeaderSection(),
                      Gap(AppSizesManager.s24),
                      TabsSection(
                        selectedTab: BlocProvider.of<RegisterCubit>(context).selectedTapIndex,
                      ),
                      Gap(AppSizesManager.s24),
                      if (BlocProvider.of<RegisterCubit>(context).selectedTapIndex == 0) EmailRegisterFormSection(),
                      if (BlocProvider.of<RegisterCubit>(context).selectedTapIndex == 1) PhoneRegisterFormSection(),
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
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
