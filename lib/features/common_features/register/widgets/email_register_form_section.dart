import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
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
            label: 'Full Name*',
            value: formData.value.fullName,
            state: FieldState.normal,
            onChanged: (newValue) {
              formData.value = formData.value.copyWith(fullName: newValue);
            },
            validationFunc: (value) {
              if (value == null || value.isEmpty) {
                return 'Full Name is required';
              }
            },
          ),
          Gap(AppSizesManager.s4),
          CustomTextField(
            label: 'Email*',
            value: formData.value.email,
            state: FieldState.normal,
            validationFunc: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              }
              if (!emailRegex.hasMatch(value)) {
                return 'Email is not valid';
              }
            },
            onChanged: (newValue) {
              formData.value = formData.value.copyWith(email: newValue);
            },
          ),
          Gap(AppSizesManager.s4),
          CustomTextField(
            label: 'Password*',
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
                return 'Password is required';
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
                label: 'Confirme Password*',
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
                    return 'Confirme Password is required';
                  }
                  if (formData.value.password != formData.value.confirmPassword) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              );
            },
          ),
          Gap(AppSizesManager.s24),
          PrimaryTextButton(
            label: "Sign up",
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
