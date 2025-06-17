import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/features/check_email/cubit/check_email_cubit.dart';

import '../../../config/theme/colors_manager.dart';
import '../../../config/theme/typoghrapy_manager.dart';
import '../../../utils/constants.dart';
import '../../common/buttons/solid/primary_text_button.dart';

class CheckEmailOtpInputSection extends StatefulWidget {
  const CheckEmailOtpInputSection({super.key});

  @override
  State<CheckEmailOtpInputSection> createState() => _CheckEmailOtpInputSectionState();
}

class _CheckEmailOtpInputSectionState extends State<CheckEmailOtpInputSection> {
  late List<TextEditingController?> controls;

  int numberOfFields = 5;

  bool clearText = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OtpTextField(
          numberOfFields: 5,
          borderColor: StrokeColors.normal.color,
          focusedBorderColor: StrokeColors.focused.color,
          clearText: clearText,
          showFieldAsBox: true,
          fieldHeight: 52.8,
          fieldWidth: 52.8,
          cursorColor: AppColors.accent1Shade1,
          alignment: Alignment.center,
          textStyle: AppTypography.body1MediumStyle.copyWith(fontSize: AppTypography.headLine4),
          handleControllers: (controllers) {
            controls = controllers;
          },
        ),
        Gap(AppSizesManager.s12),
        Padding(
          padding: const EdgeInsets.all(AppSizesManager.p12),
          child: BlocBuilder<CheckEmailCubit, CheckEmailState>(
            builder: (context, state) {
              return InkWell(
                onTap: context.read<CheckEmailCubit>().isResendActive
                    ? () => context.read<CheckEmailCubit>().resendOtp("userEmail")
                    : null,
                child: Text.rich(TextSpan(
                  children: [
                    TextSpan(
                      text: 'Resend!',
                      style: AppTypography.body3RegularStyle.copyWith(
                          color: context.read<CheckEmailCubit>().isResendActive
                              ? AppColors.accent1Shade1
                              : TextColors.secondary.color,
                          decoration: TextDecoration.underline,
                          decorationColor: TextColors.secondary.color),
                    ),
                    if (state is TimerCountChanged && !context.read<CheckEmailCubit>().isResendActive)
                      TextSpan(
                        text: ' (${state.count}s)',
                        style: AppTypography.body3RegularStyle.copyWith(
                            color: TextColors.secondary.color,
                            decoration: TextDecoration.underline,
                            decorationColor: TextColors.secondary.color),
                      ),
                  ],
                )),
              );
            },
          ),
        ),
        Gap(AppSizesManager.s24),
        PrimaryTextButton(
          label: "Verify",
          onTap: () => context.read<CheckEmailCubit>().checkEmail(controls.map((e) => e!.text).join("")),
          color: AppColors.accent1Shade1,
        ),
        Gap(AppSizesManager.s12),
        PrimaryTextButton(
          label: "Change Email",
          onTap: () {},
          labelColor: AppColors.accent1Shade1,
        ),
      ],
    );
  }

  @override
  void dispose() {
    controls.map((ctr) {
      ctr!.dispose();
    });
    super.dispose();
  }
}
