import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/check_email/cubit/check_email_cubit.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class CheckEmailOtpInputSection extends StatefulWidget {
  const CheckEmailOtpInputSection({super.key});

  @override
  State<CheckEmailOtpInputSection> createState() =>
      _CheckEmailOtpInputSectionState();
}

class _CheckEmailOtpInputSectionState extends State<CheckEmailOtpInputSection> {
  late List<TextEditingController?> controls;

  int numberOfFields = 5;

  bool clearText = false;

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

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
          textStyle: context.responsiveTextTheme.current.body1Medium.copyWith(
              fontSize: context.responsiveTextTheme.current.appFont.headLine4),
          handleControllers: (controllers) {
            controls = controllers;
          },
        ),
        const ResponsiveGap.s12(),
        Padding(
          padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p12),
          child: BlocBuilder<CheckEmailCubit, CheckEmailState>(
            builder: (context, state) {
              return InkWell(
                onTap: state.isResendActive
                    ? () => context
                        .read<CheckEmailCubit>()
                        .resendOtp(state.userEmail)
                    : null,
                child: Text.rich(TextSpan(
                  children: [
                    TextSpan(
                      text: translation.resend,
                      style: context.responsiveTextTheme.current.body3Regular
                          .copyWith(
                              color: state.isResendActive
                                  ? AppColors.accent1Shade1
                                  : TextColors.secondary.color,
                              decoration: TextDecoration.underline,
                              decorationColor: TextColors.secondary.color),
                    ),
                    if (state is TimerCountChanged && !state.isResendActive)
                      TextSpan(
                        text: ' (${state.count}s)',
                        style: context.responsiveTextTheme.current.body3Regular
                            .copyWith(
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
        const ResponsiveGap.s24(),
        PrimaryTextButton(
          label: translation.verify,
          isLoading: context.read<CheckEmailCubit>().state is CheckEmailLoading,
          onTap: () => context
              .read<CheckEmailCubit>()
              .checkEmail(controls.map((e) => e!.text).join(""), translation),
          color: AppColors.accent1Shade1,
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
