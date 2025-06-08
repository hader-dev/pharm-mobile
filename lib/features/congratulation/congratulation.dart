import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../config/theme/colors_manager.dart';
import '../../utils/constants.dart';
import 'widgets/content_section.dart';
import 'widgets/congratulation_header_section.dart';

class CongratulationScreen extends StatelessWidget {
  const CongratulationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgWhite,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
          child: Column(
            children: [
              CongratulationHeaderSection(),
              Gap(AppSizesManager.s32),
              ContentSection(),
            ],
          ),
        ),
      ),
    );
  }
}
