import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/accordions/ink_accordion.dart';
import 'package:hader_pharm_mobile/features/common/accordions/ink_accordion_item.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/actions/get_applied_para_filters_as_raw_string.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/actions/navigate_to_para_filters_apply_view.dart';
import 'package:hader_pharm_mobile/models/para_medical_filters.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class FiltersAccordionParaPharmaSpecific extends StatelessWidget {
  const FiltersAccordionParaPharmaSpecific({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    return Column(
      children: [
        InkAccordion(
          rawTitle: "${translation.para_pharma} ${translation.filters}",
          isExpanded: false,
          children: [
            InkAccordionItem(
              rawTitle: translation.filter_items_dosage,
              onTap: () => navigateToParaFiltersApplyView(
                  context, ParaMedicalFiltersKeys.dosage),
              rawSubtitle: getDisplayedParaFiltersAsRawString(
                  context, ParaMedicalFiltersKeys.dosage),
            ),
          ],
        ),
      ],
    );
  }
}
