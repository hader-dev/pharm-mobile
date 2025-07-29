import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/features/common_features/login/cubit/login_cubit.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../config/theme/colors_manager.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/enums.dart';
import '../../../common/buttons/solid/primary_text_button.dart';
import '../../../common/text_fields/custom_text_field.dart';

class LoginFormSection extends StatefulWidget {
  const LoginFormSection({super.key});

  @override
  State<LoginFormSection> createState() => _LoginFormSectionState();
}

class _LoginFormSectionState extends State<LoginFormSection> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    GlobalKey<FormFieldState> emailFieldKey = GlobalKey<FormFieldState>();
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextField(
                fieldKey: emailFieldKey,
                label: '${context.translation!.email}*',
                controller: BlocProvider.of<LoginCubit>(context).emailController,
                state: FieldState.normal,
                validationFunc: (value) {
                  if (value == null || value.isEmpty) {
                    return context.translation!.errors_field_required;
                  }
                  if (!emailRegex.hasMatch(value)) {
                    return context.translation!.errors_invalid_email_format;
                  }
                },
              ),
              Gap(AppSizesManager.s4),
              CustomTextField(
                label: '${context.translation!.password}*',
                controller: BlocProvider.of<LoginCubit>(context).passwordController,
                onChanged: (value) {},
                isObscure: BlocProvider.of<LoginCubit>(context).isObscured,
                suffixIcon: InkWell(
                    onTap: () => BlocProvider.of<LoginCubit>(context).showPassword(),
                    child: BlocProvider.of<LoginCubit>(context).isObscured
                        ? const Icon(Iconsax.eye, color: AppColors.accent1Shade1)
                        : const Icon(Iconsax.eye_slash, color: AppColors.accent1Shade1)),
                state: FieldState.normal,
                validationFunc: (value) {
                  if ((value == null || value.isEmpty) &&
                      BlocProvider.of<LoginCubit>(context).emailController.text.isNotEmpty) {
                    return context.translation!.errors_field_required;
                  }
                  if (value.length < 6) {
                    return context.translation!.passwor_min_length;
                  }
                },
              ),
              Gap(AppSizesManager.s12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Spacer(),
                  PrimaryTextButton(
                    label: context.translation!.forgot_password,
                    onTap: () {
                      if (!emailFieldKey.currentState!.validate()) {}
                      BlocProvider.of<LoginCubit>(context).forgetPassword();
                    },
                    labelColor: AppColors.accent1Shade1,
                  ),
                ],
              ),
              Gap(AppSizesManager.s24),
              PrimaryTextButton(
                label: context.translation!.login,
                isLoading: state is LoginLoading,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  BlocProvider.of<LoginCubit>(context).login(
                    context.read<LoginCubit>().emailController.text,
                    context.read<LoginCubit>().passwordController.text,
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
