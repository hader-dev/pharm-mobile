import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/go_router_extension.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/outlined/outlined_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/register/cubit/register_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'widgets/email_register_form_section.dart';
import 'widgets/register_header_section.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RegisterCubit(userManager: getItInstance.get<UserManager>()),
      child: SafeArea(
        child: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccuss) {
              GoRouter.of(context)
                  .pushReplacement(RoutingManager.checkEmailScreen, extra: {
                "email": state.email,
                "redirectTo": RoutingManager.createCompanyProfile
              });
            }
          },
          child: Scaffold(
            backgroundColor: AppColors.bgWhite,
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
              child: BlocBuilder<RegisterCubit, RegisterState>(
                builder: (context, state) {
                  return ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      RegisterHeaderSection(),
                      const ResponsiveGap.s4(),
                      const ResponsiveGap.s24(),
                      if (BlocProvider.of<RegisterCubit>(context)
                              .selectedTapIndex ==
                          0)
                        EmailRegisterFormSection(),
                      const ResponsiveGap.s16(),
                      OutLinedTextButton(
                        label: context.translation!.login_existing,
                        labelColor: AppColors.accent1Shade1,
                        isOutLined: true,
                        onTap: GoRouter.of(context).safePop,
                        borderColor: AppColors.accent1Shade1,
                      ),
                      const ResponsiveGap.s16(),
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
