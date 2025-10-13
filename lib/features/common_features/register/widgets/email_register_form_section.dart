import 'package:flutter/material.dart';
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
  const EmailRegisterFormSection({super.key});

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
              state.formData.copyWith(fullName: newVal),
            ),
            validationFunc: (value) {
              if (value == null || value.isEmpty) {
                return context.translation!.feedback_field_required;
              }
            },
          ),
          const ResponsiveGap.s4(),
          CustomTextField(
            label: '${context.translation!.email} *',
            value: state.formData.email,
            state: FieldState.normal,
            validationFunc: (value) =>
                validateIsEmail(value, context.translation!),
            onChanged: (newVal) => cubit.updateFormData(
              state.formData.copyWith(email: newVal),
            ),
          ),
          ResponsiveGap.s4(),
          CustomTextField(
            label: '${context.translation!.password}*',
            value: state.formData.password,
            isObscure: state.isObscured,
            suffixIcon: InkWell(
                onTap: () => cubit.showPassword(),
                child: state.isObscured
                    ? const Icon(Iconsax.eye, color: AppColors.accent1Shade1)
                    : const Icon(Iconsax.eye_slash,
                        color: AppColors.accent1Shade1)),
            state: FieldState.normal,
            validationFunc: (value) {
              if (value == null || value.isEmpty) {
                return context.translation!.feedback_field_required;
              }
            },
            onChanged: (newVal) =>
                cubit.updateFormData(state.formData.copyWith(password: newVal)),
          ),
          ResponsiveGap.s4(),
          BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              return CustomTextField(
                label: '${context.translation!.confirm_password}*',
                value: state.formData.confirmPassword,
                onChanged: (newVal) => cubit.updateFormData(
                    state.formData.copyWith(confirmPassword: newVal)),
                isObscure: state.isObscured,
                suffixIcon: InkWell(
                    onTap: () => cubit.showPassword(),
                    child: state.isObscured
                        ? const Icon(Iconsax.eye,
                            color: AppColors.accent1Shade1)
                        : const Icon(Iconsax.eye_slash,
                            color: AppColors.accent1Shade1)),
                state: FieldState.normal,
                validationFunc: (value) {
                  if (value == null || value.isEmpty) {
                    return context.translation!.feedback_field_required;
                  }
                  if (state.formData.password !=
                      state.formData.confirmPassword) {
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
                cubit.emailRegister(state.formData);
              }
            },
            color: AppColors.accent1Shade1,
          ),
        ],
      ),
    );
  }
}
