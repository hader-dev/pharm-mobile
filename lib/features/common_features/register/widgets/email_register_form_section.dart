import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../config/theme/colors_manager.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/enums.dart';
import '../../../common/buttons/solid/primary_text_button.dart';
import '../../../common/text_fields/custom_text_field.dart';
import '../cubit/register_cubit.dart';
import '../hooks_data_model/register_email_form.dart';

class EmailRegisterFormSection extends HookWidget {
  const EmailRegisterFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    var formData = useState(EmailRegisterFormDataModel());
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            label: '${context.translation!.full_name}*',
            value: formData.value.fullName,
            state: FieldState.normal,
            onChanged: (newValue) {
              formData.value = formData.value.copyWith(fullName: newValue);
            },
            validationFunc: (value) {
              if (value == null || value.isEmpty) {
                return context.translation!.errors_field_required;
              }
            },
          ),
          Gap(AppSizesManager.s4),
          CustomTextField(
            label: '${context.translation!.email} *',
            value: formData.value.email,
            state: FieldState.normal,
            validationFunc: (value) {
              if (value == null || value.isEmpty) {
                return context.translation!.errors_field_required;
              }
              if (!emailRegex.hasMatch(value)) {
                return context.translation!.errors_invalid_email_format;
              }
            },
            onChanged: (newValue) {
              formData.value = formData.value.copyWith(email: newValue);
            },
          ),
          Gap(AppSizesManager.s4),
          CustomTextField(
            label: '${context.translation!.password}*',
            value: formData.value.password,
            isObscure: BlocProvider.of<RegisterCubit>(context).isObscured,
            suffixIcon: InkWell(
                onTap: () => BlocProvider.of<RegisterCubit>(context).showPassword(),
                child: BlocProvider.of<RegisterCubit>(context).isObscured
                    ? const Icon(Iconsax.eye, color: AppColors.accent1Shade1)
                    : const Icon(Iconsax.eye_slash, color: AppColors.accent1Shade1)),
            state: FieldState.normal,
            validationFunc: (value) {
              if (value == null || value.isEmpty) {
                return context.translation!.errors_field_required;
              }
            },
            onChanged: (newValue) {
              formData.value = formData.value.copyWith(password: newValue);
            },
          ),
          Gap(AppSizesManager.s4),
          BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              return CustomTextField(
                label: '${context.translation!.confirm_password}*',
                value: formData.value.confirmPassword,
                onChanged: (newValue) {
                  formData.value = formData.value.copyWith(confirmPassword: newValue);
                },
                isObscure: BlocProvider.of<RegisterCubit>(context).isObscured,
                suffixIcon: InkWell(
                    onTap: () => BlocProvider.of<RegisterCubit>(context).showPassword(),
                    child: BlocProvider.of<RegisterCubit>(context).isObscured
                        ? const Icon(Iconsax.eye, color: AppColors.accent1Shade1)
                        : const Icon(Iconsax.eye_slash, color: AppColors.accent1Shade1)),
                state: FieldState.normal,
                validationFunc: (value) {
                  if (value == null || value.isEmpty) {
                    return context.translation!.errors_field_required;
                  }
                  if (formData.value.password != formData.value.confirmPassword) {
                    return context.translation!.errors_passwords_do_not_match;
                  }
                  return null;
                },
              );
            },
          ),
          Gap(AppSizesManager.s24),
          PrimaryTextButton(
            label: context.translation!.sign_up,
            isLoading: context.watch<RegisterCubit>().state is RegisterLoading,
            onTap: () {
              if (formKey.currentState!.validate()) {
                BlocProvider.of<RegisterCubit>(context).emailRegister(formData.value);
              }
            },
            color: AppColors.accent1Shade1,
          ),
        ],
      ),
    );
  }
}
