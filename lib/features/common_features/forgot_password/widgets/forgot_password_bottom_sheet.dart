import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common_features/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/validators.dart';

class RequestForgotPasswordScreen extends StatelessWidget {
  const RequestForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();
    final state = cubit.state;
    final translation = context.translation!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          DrawableAssetStrings.emailIcon,
          height: 150,
          width: 150,
        ),
        Text(context.translation!.enter_email_for_password_reset,
            textAlign: TextAlign.center,
            style: context.responsiveTextTheme.current.body1Regular),
        const ResponsiveGap.s24(),
        Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: state.forgotFormKey,
          child: CustomTextField(
              fieldKey: state.emailFieldKey,
              label: '${context.translation!.email}*',
              controller: state.emailController,
              state: FieldState.normal,
              keyBoadType: TextInputType.emailAddress,
              validationFunc: (value) =>
                  validateIsEmail(value?.trim(), translation)),
        ),
        const ResponsiveGap.s24(),
        PrimaryTextButton(
            label: context.translation!.confirm,
            onTap: () {
              if (state.forgotFormKey.currentState!.validate()) {
                cubit.forgetPassword();
              }
            },
            color: AppColors.accent1Shade1),
      ],
    );
  }
}
