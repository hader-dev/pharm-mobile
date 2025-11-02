import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
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
      padding: EdgeInsets.symmetric(
          horizontal: context.responsiveAppSizeTheme.current.p16),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        CustomStepper(
          currentStep: currentStep,
        ),
        const ResponsiveGap.s16(),
        Row(
          children: [
            Container(
              height: 45,
              width: 45,
              margin: EdgeInsets.only(
                  right: context.responsiveAppSizeTheme.current.s12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    context.responsiveAppSizeTheme.current.r4),
                color: AppColors.accentGreenShade3,
              ),
              child: Text(
                '${currentStep + 1}',
                style: context.responsiveTextTheme.current.headLine3SemiBold
                    .copyWith(color: AppColors.accent1Shade1),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pagesTitles[currentStep]["title"] ?? '',
                    style: context.responsiveTextTheme.current.headLine3SemiBold
                        .copyWith(color: AppColors.accent1Shade1),
                  ),
                  const ResponsiveGap.s4(),
                  Text(
                    pagesTitles[currentStep]["subtitle"] ?? '',
                    style: context.responsiveTextTheme.current.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        )
      ]),
    );
  }
}
