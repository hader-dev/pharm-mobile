import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/accordions/ink_accordion.dart';
import 'package:hader_pharm_mobile/features/common/accordions/ink_accordion_item.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/actions/get_applied_para_filters_as_raw_string.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/actions/navigate_to_para_filters_apply_view.dart';
import 'package:hader_pharm_mobile/models/para_medical_filters.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class FiltersAccordionParaCommercial extends StatelessWidget {
  const FiltersAccordionParaCommercial({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return Column(
      children: [
        InkAccordion(
          rawTitle: translation.filters_commercial,
          isExpanded: false,
          children: [
            InkAccordionItem(
              rawTitle: translation.filter_items_brand,
              onTap: () => navigateToParaFiltersApplyView(
                  context, ParaMedicalFiltersKeys.brand),
              rawSubtitle: getDisplayedParaFiltersAsRawString(
                  context, ParaMedicalFiltersKeys.brand),
            ),
            InkAccordionItem(
              rawTitle: translation.filter_items_type,
              onTap: () => navigateToParaFiltersApplyView(
                  context, ParaMedicalFiltersKeys.type),
              rawSubtitle: getDisplayedParaFiltersAsRawString(
                  context, ParaMedicalFiltersKeys.type),
            ),
          ],
        ),
      ],
    );
  }
}
