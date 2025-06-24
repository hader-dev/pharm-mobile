import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../config/theme/colors_manager.dart';
import '../../../../config/theme/typoghrapy_manager.dart';
import '../../../../utils/constants.dart';
import 'custom_stepper.dart';

class PageHeaderSection extends StatelessWidget {
  final int currentStep;
  final List<Map<String, String>> pagesTitles = [
    {"title": "Company Type", "subtitle": "Select the type of your company."},
    {"title": "General Information", "subtitle": "Provide your company’s basic details."},
    {"title": "Legal Information", "subtitle": "Enter your registration and license details."},
    {"title": "Company Profile", "subtitle": "Add branding and business overview."},
    {"title": "Review & Submit", "subtitle": "Review all information before submitting."},
  ];
  PageHeaderSection({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
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
                style: AppTypography.headLine3SemiBoldStyle.copyWith(color: AppColors.accent1Shade1),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pagesTitles[currentStep]["title"] ?? '',
                  style: AppTypography.headLine3SemiBoldStyle.copyWith(color: AppColors.accent1Shade1),
                ),
                Gap(AppSizesManager.s4),
                Text(pagesTitles[currentStep]["subtitle"] ?? '', style: AppTypography.bodySmallStyle),
              ],
            ),
          ],
        )
      ]),
    );
  }
}
