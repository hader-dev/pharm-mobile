import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'actions/setup_company_or_go_home.dart';
import 'cubit/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
          create: (context) => SplashCubit()..init(),
          child: BlocListener<SplashCubit, SplashState>(
            listener: setupCompanyOrGoHome,
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
                        const ResponsiveGap.s32(),
                        Text(
                          context.translation!.hader_pharm,
                          style: context.responsiveTextTheme.current.headLine1
                              .copyWith(color: TextColors.primary.color),
                        ),
                        Spacer(
                          flex: 2,
                        ),
                        CircularProgressIndicator(
                          color: AppColors.accent1Shade1,
                          constraints:
                              BoxConstraints(minHeight: 30, minWidth: 30),
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
