import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/features/common_features/profile/widgets/section_title.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'medicine_section_items.dart';

class MedicineSection extends StatelessWidget {
  const MedicineSection({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
    this.minSectionHeight = 250,
  });
  final EdgeInsets padding;
  final double minSectionHeight;

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(screenWidth <= 414 ? 0 : AppSizesManager.s4), // No gap for phones, normal gap for tablets
          SectionTitle(title: translation.medicines),
          MedicinesSectionItems(minSectionHeight: minSectionHeight),
        ],
      ),
    );
  }
}
