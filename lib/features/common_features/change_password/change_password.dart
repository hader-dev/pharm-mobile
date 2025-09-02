import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../utils/constants.dart';
import '../../../config/theme/colors_manager.dart';
import '../../../utils/enums.dart';
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
    final passwordRegex =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{6,}$');

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBarV2.alternate(
          leading: IconButton(
            icon: Icon(
              Directionality.of(context) == TextDirection.rtl
                  ? Iconsax.arrow_right_3
                  : Iconsax.arrow_left_2,
              size: AppSizesManager.iconSize25,
              color: AppColors.bgWhite,
            ),
            onPressed: () {
              context.pop();
            },
          ),
          title: Text(
            context.translation!.password,
            style: context.responsiveTextTheme.current.headLine3SemiBold
                .copyWith(color: AppColors.bgWhite),
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
                          message: context
                              .translation!.password_changed_successfully,
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
                          Gap(
                            AppSizesManager.s12,
                          ),
                          Text(context.translation!.change_password,
                              style: context
                                  .responsiveTextTheme.current.headLine2),
                          Gap(
                            AppSizesManager.s12,
                          ),
                          Text(
                              context.translation!.set_new_password_description,
                              style: context
                                  .responsiveTextTheme.current.body1Medium
                                  .copyWith(
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
                                label:
                                    '${context.translation!.current_password}*',
                                controller:
                                    BlocProvider.of<ChangePasswordCubit>(ctx)
                                        .currentPasswordController,
                                isObscure:
                                    BlocProvider.of<ChangePasswordCubit>(ctx)
                                        .isObscured,
                                suffixIcon: InkWell(
                                    onTap: () =>
                                        BlocProvider.of<ChangePasswordCubit>(
                                                ctx)
                                            .showPassword(),
                                    child: BlocProvider.of<ChangePasswordCubit>(
                                                ctx)
                                            .isObscured
                                        ? const Icon(Iconsax.eye,
                                            color: AppColors.accent1Shade1)
                                        : const Icon(Iconsax.eye_slash,
                                            color: AppColors.accent1Shade1)),
                                state: FieldState.normal,
                                validationFunc: (value) {
                                  if (value == null || value.isEmpty) {
                                    return context
                                        .translation!.feedback_field_required;
                                  }
                                },
                              ),
                              CustomTextField(
                                label: '${context.translation!.new_password}*',
                                controller:
                                    BlocProvider.of<ChangePasswordCubit>(ctx)
                                        .newPasswordController,
                                isObscure:
                                    BlocProvider.of<ChangePasswordCubit>(ctx)
                                        .isObscured,
                                suffixIcon: InkWell(
                                    onTap: () =>
                                        BlocProvider.of<ChangePasswordCubit>(
                                                ctx)
                                            .showPassword(),
                                    child: BlocProvider.of<ChangePasswordCubit>(
                                                ctx)
                                            .isObscured
                                        ? const Icon(Iconsax.eye,
                                            color: AppColors.accent1Shade1)
                                        : const Icon(Iconsax.eye_slash,
                                            color: AppColors.accent1Shade1)),
                                state: FieldState.normal,
                                validationFunc: (value) {
                                  if (value == null || value.isEmpty) {
                                    return context
                                        .translation!.feedback_field_required;
                                  }
                                  if (value.length < 6) {
                                    return context
                                        .translation!.passwor_min_length;
                                  }
                                  if (!passwordRegex.hasMatch(value)) {
                                    return context
                                        .translation!.password_requirements;
                                  }
                                },
                              ),
                              CustomTextField(
                                label:
                                    '${context.translation!.confirm_password}*',
                                controller:
                                    BlocProvider.of<ChangePasswordCubit>(ctx)
                                        .confirmPasswordController,
                                isObscure:
                                    BlocProvider.of<ChangePasswordCubit>(ctx)
                                        .isObscured,
                                suffixIcon: InkWell(
                                    onTap: () =>
                                        BlocProvider.of<ChangePasswordCubit>(
                                                ctx)
                                            .showPassword(),
                                    child: BlocProvider.of<ChangePasswordCubit>(
                                                ctx)
                                            .isObscured
                                        ? const Icon(Iconsax.eye,
                                            color: AppColors.accent1Shade1)
                                        : const Icon(Iconsax.eye_slash,
                                            color: AppColors.accent1Shade1)),
                                state: FieldState.normal,
                                validationFunc: (value) {
                                  if (value == null || value.isEmpty) {
                                    return context
                                        .translation!.feedback_field_required;
                                  }
                                  if (value.length < 6) {
                                    return context
                                        .translation!.passwor_min_length;
                                  }
                                  if (value !=
                                      BlocProvider.of<ChangePasswordCubit>(ctx)
                                          .newPasswordController
                                          .text) {
                                    return context.translation!
                                        .feedback_passwords_do_not_match;
                                  }
                                },
                              ),
                            ],
                          ),
                          const ResponsiveGap.s16(),
                          PrimaryTextButton(
                            label: context.translation!.change_password,
                            isLoading: state is ChangePasswordLoading,
                            onTap: () {
                              if (!Form.of(ctx).validate()) {
                                return;
                              }
                              BlocProvider.of<ChangePasswordCubit>(ctx)
                                  .changePassword();
                            },
                            color: AppColors.accent1Shade1,
                          ),
                          const ResponsiveGap.s24(),
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
