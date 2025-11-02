import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../config/theme/colors_manager.dart';
import '../../../common/buttons/solid/primary_text_button.dart';

class CheckPhoneOtpInputSection extends StatelessWidget {
  final int numberOfFields = 5;
  final bool clearText = false;
  const CheckPhoneOtpInputSection({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    late List<TextEditingController?> controls;

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
          onCodeChanged: (String value) {
            //Handle each value
          },
          handleControllers: (controllers) {
            //get all textFields controller, if needed
            controls = controllers;
          },
          onSubmit: (String verificationCode) {}, // end onSubmit
        ),
        const ResponsiveGap.s12(),
        Padding(
          padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p12),
          child: Text(
            "Resend! (5s)",
            style: context.responsiveTextTheme.current.body3Regular.copyWith(
                color: TextColors.secondary.color,
                decoration: TextDecoration.underline,
                decorationColor: TextColors.secondary.color),
          ),
        ),
        const ResponsiveGap.s24(),
        PrimaryTextButton(
          label: context.translation!.verify,
          onTap: () {},
          color: AppColors.accent1Shade1,
        ),
        const ResponsiveGap.s12(),
        PrimaryTextButton(
          label: context.translation!.change_phone_number,
          onTap: () {},
          labelColor: AppColors.accent1Shade1,
        ),
      ],
    );
  }
}
