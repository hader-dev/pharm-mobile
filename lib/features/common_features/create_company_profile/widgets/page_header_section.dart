import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'custom_stepper.dart';

class PageHeaderSection extends StatelessWidget {
  final int currentStep;

  const PageHeaderSection({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> pagesTitles = [
      {
        "title": context.translation!.company_type_title,
        "subtitle": context.translation!.company_type_subtitle,
      },
      {
        "title": context.translation!.general_info_title,
        "subtitle": context.translation!.general_info_subtitle,
      },
      {
        "title": context.translation!.legal_info_title,
        "subtitle": context.translation!.legal_info_subtitle,
      },
      {
        "title": context.translation!.company_profile_title,
        "subtitle": context.translation!.company_profile_subtitle,
      },
      {
        "title": context.translation!.review_submit_title,
        "subtitle": context.translation!.review_submit_subtitle,
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        CustomStepper(
          currentStep: currentStep,
        ),
        Gap(AppSizesManager.s16),
        Row(
          children: [
            Container(
              height: 45,
              width: 45,
              margin: EdgeInsets.only(right: AppSizesManager.s12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizesManager.r4),
                color: AppColors.accentGreenShade3,
              ),
              child: Text(
                '${currentStep + 1}',
                style: AppTypography.headLine3SemiBoldStyle
                    .copyWith(color: AppColors.accent1Shade1),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pagesTitles[currentStep]["title"] ?? '',
                  style: AppTypography.headLine3SemiBoldStyle
                      .copyWith(color: AppColors.accent1Shade1),
                ),
                Gap(AppSizesManager.s4),
                Text(pagesTitles[currentStep]["subtitle"] ?? '',
                    style: AppTypography.bodySmallStyle),
              ],
            ),
          ],
        )
      ]),
    );
  }
}
