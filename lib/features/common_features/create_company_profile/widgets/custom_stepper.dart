import 'package:flutter/material.dart';
import '../../../../config/theme/colors_manager.dart';
import '../../../../utils/constants.dart';

class CustomStepper extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  const CustomStepper({super.key, required this.currentStep, this.totalSteps = 5});

  @override
  Widget build(BuildContext context) {
    return Row(
        children: List.generate(totalSteps, (index) {
      return Flexible(
        flex: 1,
        child: Container(
          height: 4,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizesManager.r4),
              color: currentStep == index ? AppColors.accent1Shade1 : AppColors.accent1Shade3),
        ),
      );
    }));
  }
}
