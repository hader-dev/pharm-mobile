import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common_features/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class PasswordResetOtpScreen extends StatelessWidget {
  const PasswordResetOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    final cubit = context.read<ForgotPasswordCubit>();
    late List<TextEditingController?> controls;

    return BlocBuilder<ForgotPasswordCubit, ForgotPaswordState>(
        builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Gap(AppSizesManager.s24),
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Iconsax.arrow_left,
                  color: Colors.black,
                  size: AppSizesManager.iconSize25,
                ),
                onPressed: () => cubit.navigateBack(),
              ),
              Text(
                context.translation!.new_password,
                style: context.responsiveTextTheme.current.headLine3SemiBold
                    .copyWith(
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Gap(AppSizesManager.s24),
          Text(
            context.translation!.hint_please_enter_otp_sent_to_email,
            textAlign: TextAlign.center,
            style:
                context.responsiveTextTheme.current.headLine4Medium.copyWith(
              color: AppColors.accent1Shade1,
            ),
          ),
          const Gap(AppSizesManager.s24),
          OtpTextField(
            numberOfFields: 5,
            borderColor: StrokeColors.normal.color,
            focusedBorderColor: StrokeColors.focused.color,
            clearText: true,
            showFieldAsBox: true,
            fieldHeight: 52.8,
            fieldWidth: 52.8,
            cursorColor: AppColors.accent1Shade1,
            alignment: Alignment.center,
            textStyle: context.responsiveTextTheme.current.body1Medium.copyWith(
                fontSize:
                    context.responsiveTextTheme.current.appFont.headLine4),
            handleControllers: (controllers) {
              controls = controllers;
            },
          ),
          const Gap(AppSizesManager.s24),
          Form(
            key: cubit.formKey,
            child: CustomTextField(
              fieldKey: cubit.passwordFieldKey,
              label: '${context.translation!.new_password}*',
              controller: BlocProvider.of<ForgotPasswordCubit>(context)
                  .newPasswordController,
              state: FieldState.normal,
              validationFunc: (value) {
                if (value == null || value.isEmpty) {
                  return context.translation!.feedback_field_required;
                }
              },
              isObscure: cubit.isObscured,
              suffixIcon: InkWell(
                  onTap: () => cubit.showPassword(),
                  child: cubit.isObscured
                      ? const Icon(Iconsax.eye, color: AppColors.accent1Shade1)
                      : const Icon(Iconsax.eye_slash,
                          color: AppColors.accent1Shade1)),
            ),
          ),
          Gap(AppSizesManager.s24),

          PrimaryTextButton(
            label: translation.verify,
            isLoading: cubit.state is ResetpasswordIsLoading,
            onTap: () => cubit.resetPassword(
                controls.map((e) => e!.text).join(""), translation),
            color: AppColors.accent1Shade1,
          ),
        ],
      );
    });
  }
}
