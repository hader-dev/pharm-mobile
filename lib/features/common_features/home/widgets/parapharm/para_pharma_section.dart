import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/home/widgets/parapharm/para_pharma_section_items.dart';
import 'package:hader_pharm_mobile/features/common_features/profile/widgets/section_title.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class ParapharmaSection extends StatelessWidget {
  const ParapharmaSection({
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
          const ResponsiveGap.s4(),
          SectionTitle(title: translation.para_pharma),
          ParaPharmaSectionItems(
            minSectionHeight: minSectionHeight,
          ),
        ],
      ),
    );
  }
}
