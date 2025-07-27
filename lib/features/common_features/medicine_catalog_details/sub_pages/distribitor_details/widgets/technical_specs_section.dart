import 'package:flutter/material.dart';

import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/sub_pages/review_and_sumbit/widgets/info_row.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

import '../../../../../../config/theme/typoghrapy_manager.dart';

class SpecificationsWidget extends StatelessWidget {
  final Map<String, String> specifications;

  const SpecificationsWidget({super.key, this.specifications = const {}});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpansionTile(
          tilePadding: const EdgeInsets.all(0),
          title: Text(
            'Details',
            style: AppTypography.headLine3SemiBoldStyle.copyWith(color: AppColors.accent1Shade1),
          ),
          dense: true,
          initiallyExpanded: true,
          maintainState: true,
          trailing: Text(
            'Show',
            style: AppTypography.body3MediumStyle,
          ),
          children: [
            ...specifications.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSizesManager.s8,
                ),
                child: InfoRow(label: entry.key, dataValue: entry.value.isNotEmpty ? entry.value : "No data available"),
              );
            }),
          ],
        ),
      ],
    );
  }
}
