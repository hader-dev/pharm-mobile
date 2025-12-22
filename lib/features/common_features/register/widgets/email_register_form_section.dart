import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common_features/register/cubit/register_cubit.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/validators.dart';
import 'package:iconsax/iconsax.dart';

class EmailRegisterFormSection extends HookWidget {
  const EmailRegisterFormSection({super.key, this.token});
  final String? token;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    final state = cubit.state;

    return Form(
      key: state.formKey,
      child: Column(
        children: [
          CustomTextField(
            label: '${context.translation!.full_name}*',
            value: state.formData.fullName,
            state: FieldState.normal,
            onChanged: (newVal) => cubit.updateFormData(
              state.formData.copyWith(fullName: newVal?.trim()),
            ),
            validationFunc: (value) {
              if (value?.trim() == null || value!.trim().isEmpty) {
                return context.translation!.feedback_field_required;
              }
            },
          ),
          const ResponsiveGap.s4(),
          CustomTextField(
            label: '${context.translation!.email} *',
            value: state.formData.email,
            state: FieldState.normal,
            formatters: [
              FilteringTextInputFormatter.deny(RegExp(r'\s')),
            ],
            keyBoadType: TextInputType.emailAddress,
            validationFunc: (value) =>
                validateIsEmail(value?.trim(), context.translation!),
            onChanged: (newVal) => cubit.updateFormData(
              state.formData.copyWith(email: newVal?.trim()),
            ),
          ),
          ResponsiveGap.s4(),
          CustomTextField(
            label: '${context.translation!.password}*',
            value: state.formData.password,
            isObscure: state.isObscured,
            formatters: [
              FilteringTextInputFormatter.deny(RegExp(r'\s')),
            ],
            suffixIcon: InkWell(
                onTap: () => cubit.showPassword(),
                child: state.isObscured
                    ? const Icon(Iconsax.eye, color: AppColors.accent1Shade1)
                    : const Icon(Iconsax.eye_slash,
                        color: AppColors.accent1Shade1)),
            state: FieldState.normal,
            validationFunc: (value) {
              final trimmedValue = value?.trim();
              if (trimmedValue == null || trimmedValue.isEmpty) {
                return context.translation!.feedback_field_required;
              }
            },
            onChanged: (newVal) => cubit.updateFormData(
                state.formData.copyWith(password: newVal?.trim())),
          ),
          ResponsiveGap.s4(),
          BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              return CustomTextField(
                label: '${context.translation!.confirm_password}*',
                value: state.formData.confirmPassword,
                onChanged: (newVal) => cubit.updateFormData(
                    state.formData.copyWith(confirmPassword: newVal?.trim())),
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
                  if (trimmedValue == null || trimmedValue.isEmpty) {
                    return context.translation!.feedback_field_required;
                  }
                  if (state.formData.password.trim() !=
                      state.formData.confirmPassword.trim()) {
                    return context.translation!.feedback_passwords_do_not_match;
                  }
                  return null;
                },
              );
            },
          ),
          const ResponsiveGap.s24(),
          PrimaryTextButton(
            label: context.translation!.sign_up,
            isLoading: context.watch<RegisterCubit>().state is RegisterLoading,
            onTap: () {
              if (state.formKey.currentState!.validate()) {
                cubit.emailRegister(state.formData, token);
              }
            },
            color: AppColors.accent1Shade1,
          ),
        ],
      ),
    );
  }
}
