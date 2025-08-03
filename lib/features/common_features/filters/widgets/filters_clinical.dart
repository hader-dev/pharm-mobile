import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/accordions/ink_accordion.dart';
import 'package:hader_pharm_mobile/features/common/accordions/ink_accordion_item.dart';
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
                rawTitle: translation.filter_items_dci, onTap: () {}),
            InkAccordionItem(
                rawTitle: translation.filter_items_dosage, onTap: () {}),
            InkAccordionItem(
                rawTitle: translation.filter_items_form, onTap: () {})
          ],
        ),
      ],
    );
  }
}
