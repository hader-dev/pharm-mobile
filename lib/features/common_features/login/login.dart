import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/outlined/outlined_icon_button.dart';
import 'package:hader_pharm_mobile/features/common/buttons/outlined/outlined_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/dividers.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/forgot_password/forgot_password.dart';
import 'package:hader_pharm_mobile/features/common_features/login/cubit/login_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/login/widgets/loading_google_auth_dialog.dart'
    show GoogleAuthLoadingDialog;
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'actions/setup_company_or_go_home.dart';
import 'widgets/login_form_section.dart';
import 'widgets/login_header_section.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userManager = getItInstance.get<UserManager>();

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (BuildContext context, LoginState state) async {
          if (state is LoginSuccessful) {
            setupCompanyOrSkipToHome();
          }

          if (state is GoogleLoginLoading) {
            await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => Dialog(
                      // constraints: BoxConstraints(maxHeight: 500),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(context.responsiveAppSizeTheme.current.commonWidgetsRadius)),
                      backgroundColor: AppColors.bgWhite,
                      child: GoogleAuthLoadingDialog(),
                    ));
          }
          if (state is ForgotPassword) {
            BottomSheetHelper.showCommonBottomSheet(context: context, child: ForgotPasswordScreen());
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.bgWhite,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.responsiveAppSizeTheme.current.p16),
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  LoginHeaderSection(),
                  const ResponsiveGap.s24(),
                  LoginFormSection(),
                  const ResponsiveGap.s16(),
                  OutLinedTextButton(
                    label: context.translation!.register,
                    labelColor: AppColors.accent1Shade1,
                    isOutLined: true,
                    onTap: () {
                      GoRouter.of(context).push(RoutingManager.registerScreen);
                    },
                    borderColor: AppColors.accent1Shade1,
                  ),
                  const AppDivider(
                    color: AppColors.accent1Shade1,
                  ),
                  if (userManager.isGoogleSiginInSupported())
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        return OutlinedIconButton(
                          borderColor: AppColors.accent1Shade1,
                          label: Text(
                            context.translation!.login_with_google,
                            style: context.responsiveTextTheme.current.body1Regular
                                .copyWith(color: AppColors.accent1Shade1),
                          ),
                          icon: SvgPicture.asset(
                            DrawableAssetStrings.googleIcon,
                            height: context.responsiveAppSizeTheme.current.iconSize20,
                            width: context.responsiveAppSizeTheme.current.iconSize20,
                          ),
                          onPressed: () {
                            context.read<LoginCubit>().loginWithGoogle();
                          },
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
