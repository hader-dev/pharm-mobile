import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'widgets/congratulation_header_section.dart';
import 'widgets/content_section.dart';

class CongratulationScreen extends StatelessWidget {
  const CongratulationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgWhite,
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.responsiveAppSizeTheme.current.p16),
          child: Column(
            children: [
              CongratulationHeaderSection(),
              const ResponsiveGap.s32(),
              ContentSection(),
            ],
          ),
        ),
      ),
    );
  }
}
