import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class CustomStepper extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  const CustomStepper(
      {super.key, required this.currentStep, this.totalSteps = 5});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        totalSteps,
        (index) {
          return Flexible(
            flex: 1,
            child: Container(
              height: 4,
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      context.responsiveAppSizeTheme.current.r4),
                  color: currentStep == index
                      ? AppColors.accent1Shade1
                      : AppColors.accent1Shade3),
            ),
          );
        },
      ),
    );
  }
}
