import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

import '../../../config/routes/routing_manager.dart';
import '../../../config/theme/typoghrapy_manager.dart';
import 'cubit/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
          create: (context) => SplashCubit()..init(),
          child: BlocListener<SplashCubit, SplashState>(
            listener: (context, state) {
              if (state is UserNotLoggedInYet || state is SplashFailed) {
                GoRouter.of(context).pushReplacementNamed(RoutingManager.loginScreen);
              }
              if (state is SplashCompleted) {
                GoRouter.of(context).pushReplacementNamed(RoutingManager.appLayout);
              }
            },
            child: BlocBuilder<SplashCubit, SplashState>(
              builder: (context, state) {
                return Scaffold(
                  body: SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        Spacer(
                          flex: 3,
                        ),
                        SvgPicture.asset(
                          DrawableAssetStrings.logoImg,
                          height: 145,
                          width: 145,
                        ),
                        Gap(AppSizesManager.s32),
                        Text(
                          'HADER PHARM',
                          style: AppTypography.headLine1Style.copyWith(color: TextColors.primary.color),
                        ),
                        Spacer(
                          flex: 2,
                        ),
                        CircularProgressIndicator(
                          color: AppColors.accent1Shade1,
                          constraints: BoxConstraints(minHeight: 30, minWidth: 30),
                        ),
                        Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }
}
