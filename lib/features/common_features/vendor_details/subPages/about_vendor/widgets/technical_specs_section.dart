import 'package:flutter/material.dart';

import 'package:hader_pharm_mobile/features/common_features/create_company_profile/sub_pages/review_and_sumbit/widgets/info_row.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

class SpecificationsWidget extends StatelessWidget {
  final Map<String, String> specifications;

  const SpecificationsWidget({super.key, this.specifications = const {}});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...specifications.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSizesManager.s8,
            ),
            child: InfoRow(
                label: entry.key,
                contentDirection: Axis.vertical,
                dataValue:
                    entry.value.isNotEmpty ? entry.value : "No data available"),
          );
        }),
      ],
    );
  }
}
