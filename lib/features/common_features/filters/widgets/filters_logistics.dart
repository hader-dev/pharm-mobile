import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/accordions/ink_accordion.dart';
import 'package:hader_pharm_mobile/features/common/accordions/ink_accordion_item.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/actions/get_applied_filters_as_raw_string.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/actions/navigate_to_medical_filters_apply_view.dart';
import 'package:hader_pharm_mobile/models/medical_filters.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class FiltersAccordionLogistics extends StatelessWidget {
  const FiltersAccordionLogistics({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    return Column(
      children: [
        InkAccordion(
          rawTitle: translation.filters_logisctics,
          isExpanded: false,
          children: [
            InkAccordionItem(
              rawTitle: translation.filter_items_stability_duration,
              onTap: () => navigateToMedicalFiltersApplyView(
                  context, MedicalFiltersKeys.stabilityDuration),
              rawSubtitle: getDisplayedFiltersAsRawString(
                  context, MedicalFiltersKeys.stabilityDuration),
            ),
            InkAccordionItem(
              rawTitle: translation.filter_items_country,
              onTap: () => navigateToMedicalFiltersApplyView(
                  context, MedicalFiltersKeys.country),
              rawSubtitle: getDisplayedFiltersAsRawString(
                  context, MedicalFiltersKeys.country),
            ),
          ],
        ),
      ],
    );
  }
}
