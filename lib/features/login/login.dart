import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/features/login/cubit/login_cubit.dart';
import 'package:hader_pharm_mobile/repositories/remote/user/user_repository_impl.dart';

import '../../config/services/network/network_interface.dart';
import '../../config/theme/colors_manager.dart';
import '../../utils/constants.dart';
import '../common/buttons/outlined/outlined_text_button.dart';
import 'widgets/login_form_section.dart';
import 'widgets/login_header_section.dart';
import 'widgets/other_login_options_section.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => LoginCubit(userRepository: UserRepository(client: getItInstance.get<INetworkService>())),
        child: BlocListener<LoginCubit, LoginState>(
          listener: (BuildContext context, LoginState state) {
            if (state is LoginSuccessful) {
              context.goNamed(RoutingManager.splashScreen);
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
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      return LoginFormSection();
                    },
                  ),
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
