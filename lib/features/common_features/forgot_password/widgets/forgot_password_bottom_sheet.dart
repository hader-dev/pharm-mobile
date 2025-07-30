import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common_features/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class RequestForgotPasswordScreen extends StatelessWidget {
  const RequestForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    GlobalKey<FormFieldState> emailFieldKey = GlobalKey<FormFieldState>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            DrawableAssetStrings.emailIcon,
            height: 150,
            width: 150,
          ),
          Text(context.translation!.enter_email_for_password_reset,
              textAlign: TextAlign.center,
              style: AppTypography.body1RegularStyle),
          const Gap(AppSizesManager.s24),
          Form(
            key: formKey,
            child: CustomTextField(
              fieldKey: emailFieldKey,
              label: '${context.translation!.email}*',
              controller:
                  BlocProvider.of<ForgotPasswordCubit>(context).emailController,
              state: FieldState.normal,
              validationFunc: (value) {
                if (value == null || value.isEmpty) {
                  return context.translation!.feedback_field_required;
                }
                if (!emailRegex.hasMatch(value)) {
                  return context.translation!.feedback_invalid_email_format;
                }
              },
            ),
          ),
          const Gap(AppSizesManager.s24),
          PrimaryTextButton(
              label: context.translation!.confirm,
              onTap: () {
                BlocProvider.of<ForgotPasswordCubit>(context).forgetPassword();
              },
              color: AppColors.accent1Shade1),
        ],
      ),
    );
  }
}
