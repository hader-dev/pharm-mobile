import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common_features/login/cubit/login_cubit.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/validators.dart';
import 'package:iconsax/iconsax.dart';

class LoginFormSection extends StatefulWidget {
  const LoginFormSection({super.key});

  @override
  State<LoginFormSection> createState() => _LoginFormSectionState();
}

class _LoginFormSectionState extends State<LoginFormSection> {
  @override
  Widget build(BuildContext context) {
    LoginCubit cubit = context.read<LoginCubit>();

    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Form(
          key: state.formKey,
          child: Column(
            children: [
              CustomTextField(
                fieldKey: state.emailFieldKey,
                label: '${context.translation!.email}*',
                controller: state.emailController,
                verticalPadding: context.responsiveAppSizeTheme.current.p6,
                state: FieldState.normal,
                formatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
                keyBoadType: TextInputType.emailAddress,
                validationFunc: (value) => validateIsEmail(value?.trim(), context.translation!),
              ),
              CustomTextField(
                label: '${context.translation!.password}*',
                controller: state.passwordController,
                onChanged: (value) {},
                isObscure: state.isObscured,
                formatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
                suffixIcon: InkWell(
                    onTap: () => cubit.showPassword(),
                    child: state.isObscured
                        ? Icon(Iconsax.eye,
                            size: context.responsiveAppSizeTheme.current.iconSize20, color: AppColors.accent1Shade1)
                        : Icon(Iconsax.eye_slash,
                            size: context.responsiveAppSizeTheme.current.iconSize20, color: AppColors.accent1Shade1)),
                state: FieldState.normal,
                verticalPadding: context.responsiveAppSizeTheme.current.p6,
                validationFunc: (value) {
                  final trimmedValue = value?.trim();
                  if ((trimmedValue == null || trimmedValue.isEmpty) && state.emailController.text.isNotEmpty) {
                    return context.translation!.feedback_field_required;
                  }
                  if (trimmedValue != null && trimmedValue.length < 6) {
                    return context.translation!.passwor_min_length;
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      cubit.forgetPassword();
                    },
                    child: Text(
                      context.translation!.forgot_password,
                      style: context.responsiveTextTheme.current.body3Medium.copyWith(color: AppColors.accent1Shade1),
                    ),
                  ),
                ],
              ),
              const ResponsiveGap.s32(),
              BlocBuilder<LoginCubit, LoginState>(
                buildWhen: (previous, current) =>
                    current is LoginLoading || current is LoginSuccessful || current is LoginFailed,
                builder: (context, state) {
                  return PrimaryTextButton(
                    label: context.translation!.login,
                    isLoading: state is LoginLoading,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if (!state.formKey.currentState!.validate()) {
                        return;
                      }
                      cubit.login(
                        state.emailController.text.trim(),
                        state.passwordController.text.trim(),
                      );
                    },
                    color: AppColors.accent1Shade1,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
