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
                state: FieldState.normal,
                formatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
                keyBoadType: TextInputType.emailAddress,
                validationFunc: (value) =>
                    validateIsEmail(value?.trim(), context.translation!),
              ),
              const ResponsiveGap.s4(),
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
                        ? const Icon(Iconsax.eye,
                            color: AppColors.accent1Shade1)
                        : const Icon(Iconsax.eye_slash,
                            color: AppColors.accent1Shade1)),
                state: FieldState.normal,
                validationFunc: (value) {
                  final trimmedValue = value?.trim();
                  if ((trimmedValue == null || trimmedValue.isEmpty) &&
                      state.emailController.text.isNotEmpty) {
                    return context.translation!.feedback_field_required;
                  }
                  if (trimmedValue != null && trimmedValue.length < 6) {
                    return context.translation!.passwor_min_length;
                  }
                },
              ),
              const ResponsiveGap.s12(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  PrimaryTextButton(
                    label: context.translation!.forgot_password,
                    onTap: () {
                      cubit.forgetPassword();
                    },
                    labelColor: AppColors.accent1Shade1,
                  ),
                ],
              ),
              const ResponsiveGap.s24(),
              PrimaryTextButton(
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
              ),
            ],
          ),
        );
      },
    );
  }
}
