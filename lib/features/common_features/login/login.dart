import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/login/cubit/login_cubit.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../config/theme/colors_manager.dart';
import '../../../utils/bottom_sheet_helper.dart';
import '../../../utils/constants.dart';
import '../../common/buttons/outlined/outlined_text_button.dart';
import 'widgets/login_form_section.dart';
import 'widgets/login_header_section.dart';
import 'widgets/reset_password_link_sent_bottom_sheet.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocListener<LoginCubit, LoginState>(
          listener: (BuildContext context, LoginState state) {
            if (state is LoginSuccessful) {
              context.goNamed(RoutingManager.appLayout);
            }
            if (state is ResetLinkSent) {
              BottomSheetHelper.showCommonBottomSheet(context: context, child: CheckYourMailScreen());
            }
            if (state is EmailOtpResentSuccessfully) {
              GoRouter.of(context).goNamed(RoutingManager.checkEmailScreen,
                  extra: {"email": state.email, "redirectTo": RoutingManager.loginScreen});
            }
          },
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
                  Gap(AppSizesManager.s16),
                  OutLinedTextButton(
                    label: context.translation!.register,
                    labelColor: AppColors.accent1Shade1,
                    isOutLined: true,
                    onTap: () {
                      GoRouter.of(context).pushReplacementNamed(RoutingManager.registerScreen);
                    },
                    borderColor: AppColors.accent1Shade1,
                  ),
                  Gap(AppSizesManager.s16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
