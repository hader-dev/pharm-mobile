import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/accordions/ink_accordion.dart';
import 'package:hader_pharm_mobile/features/common/accordions/ink_accordion_item.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/actions/navigate_to_filters_apply_view.dart';
import 'package:hader_pharm_mobile/models/medical_filters.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class FiltersAccordionRegulatory extends StatelessWidget {
  const FiltersAccordionRegulatory({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    return Column(
      children: [
        InkAccordion(
          rawTitle: translation.filters_regulatory,
          isExpanded: false,
          children: [
            InkAccordionItem(
                rawTitle: translation.filter_items_status,
                onTap: () => navigateToFiltersApplyView(
                    context, MedicalFiltersKeys.status)),
            InkAccordionItem(
                rawTitle: translation.filter_items_register_date,
                onTap: () => {}),
         
            InkAccordionItem(
                rawTitle: translation.filter_items_patent,
                onTap: () => navigateToFiltersApplyView(
                    context, MedicalFiltersKeys.patent)),
          ],
        ),
      ],
    );
  }
}
