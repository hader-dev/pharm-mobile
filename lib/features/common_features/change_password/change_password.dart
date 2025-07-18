import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';

import '../../../../../../utils/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../config/theme/colors_manager.dart';
import '../../../config/theme/typoghrapy_manager.dart';
import '../../../utils/enums.dart';
import '../../common/app_bars/custom_app_bar.dart';
import '../../common/buttons/solid/primary_text_button.dart';
import '../../common/text_fields/custom_text_field.dart';
import 'cubit/change_password_cubit.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{6,}$');

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          bgColor: AppColors.bgWhite,
          topPadding: MediaQuery.of(context).padding.top,
          bottomPadding: MediaQuery.of(context).padding.bottom,
          leading: IconButton(
            icon: const Icon(
              Iconsax.arrow_left_2,
              size: AppSizesManager.iconSize25,
            ),
            onPressed: () {
              context.pop();
            },
          ),
          title: const Text(
            "Update Password",
            style: AppTypography.headLine3SemiBoldStyle,
          ),
        ),
        body: BlocProvider(
          create: (ctx) => ChangePasswordCubit(),
          child: Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizesManager.p16,
              ),
              child: BlocListener<ChangePasswordCubit, ChangePasswordState>(
                listener: (BuildContext context, ChangePasswordState state) {
                  if (state is ChangePasswordSuccessful) {
                    getItInstance.get<ToastManager>().showToast(
                          message: "Password changed successfully",
                          type: ToastType.success,
                        );
                  }
                },
                child: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                  builder: (BuildContext ctx, ChangePasswordState state) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Set a new password", style: AppTypography.headLine2Style),
                          Gap(
                            AppSizesManager.s12,
                          ),
                          Text("Create a new password. Ensure it differs from previous ones for security",
                              style: AppTypography.body1MediumStyle.copyWith(
                                color: TextColors.ternary.color,
                              )),
                          const Gap(
                            AppSizesManager.s24,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CustomTextField(
                                label: 'Current Password*',
                                controller: BlocProvider.of<ChangePasswordCubit>(ctx).currentPasswordController,
                                isObscure: BlocProvider.of<ChangePasswordCubit>(ctx).isObscured,
                                suffixIcon: InkWell(
                                    onTap: () => BlocProvider.of<ChangePasswordCubit>(ctx).showPassword(),
                                    child: BlocProvider.of<ChangePasswordCubit>(ctx).isObscured
                                        ? const Icon(Iconsax.eye, color: AppColors.accent1Shade1)
                                        : const Icon(Iconsax.eye_slash, color: AppColors.accent1Shade1)),
                                state: FieldState.normal,
                                validationFunc: (value) {
                                  if (value == null || value.isEmpty) {
                                    return context.translation!.fieldRequired;
                                  }
                                },
                              ),
                              CustomTextField(
                                label: 'New password*',
                                controller: BlocProvider.of<ChangePasswordCubit>(ctx).newPasswordController,
                                isObscure: BlocProvider.of<ChangePasswordCubit>(ctx).isObscured,
                                suffixIcon: InkWell(
                                    onTap: () => BlocProvider.of<ChangePasswordCubit>(ctx).showPassword(),
                                    child: BlocProvider.of<ChangePasswordCubit>(ctx).isObscured
                                        ? const Icon(Iconsax.eye, color: AppColors.accent1Shade1)
                                        : const Icon(Iconsax.eye_slash, color: AppColors.accent1Shade1)),
                                state: FieldState.normal,
                                validationFunc: (value) {
                                  if (value == null || value.isEmpty) {
                                    return context.translation!.fieldRequired;
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  if (!passwordRegex.hasMatch(value)) {
                                    return 'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character.';
                                  }
                                },
                              ),
                              CustomTextField(
                                label: 'Confirm password*',
                                controller: BlocProvider.of<ChangePasswordCubit>(ctx).confirmPasswordController,
                                isObscure: BlocProvider.of<ChangePasswordCubit>(ctx).isObscured,
                                suffixIcon: InkWell(
                                    onTap: () => BlocProvider.of<ChangePasswordCubit>(ctx).showPassword(),
                                    child: BlocProvider.of<ChangePasswordCubit>(ctx).isObscured
                                        ? const Icon(Iconsax.eye, color: AppColors.accent1Shade1)
                                        : const Icon(Iconsax.eye_slash, color: AppColors.accent1Shade1)),
                                state: FieldState.normal,
                                validationFunc: (value) {
                                  if (value == null || value.isEmpty) {
                                    return context.translation!.fieldRequired;
                                  }
                                  if (value.length < 6) {
                                    return 'Confirm Password must be at least 6 characters';
                                  }
                                  if (value != BlocProvider.of<ChangePasswordCubit>(ctx).newPasswordController.text) {
                                    return 'Passwords do not match';
                                  }
                                },
                              ),
                            ],
                          ),
                          Gap(AppSizesManager.s16),
                          PrimaryTextButton(
                            label: "Update password",
                            isLoading: state is ChangePasswordLoading,
                            onTap: () {
                              if (!Form.of(ctx).validate()) {
                                return;
                              }
                              BlocProvider.of<ChangePasswordCubit>(ctx).changePassword();
                            },
                            color: AppColors.accent1Shade1,
                          ),
                          Gap(AppSizesManager.s24),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
