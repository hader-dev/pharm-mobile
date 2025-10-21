import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/accordions/ink_accordion.dart';
import 'package:hader_pharm_mobile/features/common/accordions/ink_accordion_item.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/actions/get_applied_filters_as_raw_string.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/actions/navigate_to_medical_filters_apply_view.dart';
import 'package:hader_pharm_mobile/models/medical_filters.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class FiltersAccordionClinical extends StatelessWidget {
  const FiltersAccordionClinical({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return Column(
      children: [
        InkAccordion(
          rawTitle: translation.filters_clinincal,
          isExpanded: false,
          children: [
            InkAccordionItem(
              rawTitle: translation.filter_items_dci,
              onTap: () => navigateToMedicalFiltersApplyView(
                  context, MedicalFiltersKeys.dci),
              rawSubtitle: getDisplayedFiltersAsRawString(
                  context, MedicalFiltersKeys.dci),
            ),
            InkAccordionItem(
              rawTitle: translation.filter_items_dosage,
              onTap: () => navigateToMedicalFiltersApplyView(
                  context, MedicalFiltersKeys.dosage),
              rawSubtitle: getDisplayedFiltersAsRawString(
                  context, MedicalFiltersKeys.dosage),
            ),
            InkAccordionItem(
              rawTitle: translation.filter_items_form,
              onTap: () => navigateToMedicalFiltersApplyView(
                  context, MedicalFiltersKeys.form),
              rawSubtitle: getDisplayedFiltersAsRawString(
                  context, MedicalFiltersKeys.form),
            ),
          ],
        ),
      ],
    );
  }
}
