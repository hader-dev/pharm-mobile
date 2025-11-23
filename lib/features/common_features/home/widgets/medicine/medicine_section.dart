import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/widgets/section_title.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'medicine_section_items.dart';

class MedicineSection extends StatelessWidget {
  const MedicineSection({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
    this.minSectionHeight = 280,
  });
  final EdgeInsets padding;
  final double minSectionHeight;

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
            title: translation.medicines,
            iconPath: DrawableAssetStrings.newMedicinesIcon,
            isSeeAllEnabled: true,
          ),
          MedicinesSectionItems(minSectionHeight: minSectionHeight),
        ],
      ),
    );
  }
}
