import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/accordions/ink_accordion.dart';
import 'package:hader_pharm_mobile/features/common/accordions/ink_accordion_item.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class FiltersAccordionCommercial extends StatelessWidget {
  const FiltersAccordionCommercial({super.key});

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
                rawTitle: translation.filter_items_brand, onTap: () {}),
            InkAccordionItem(
                rawTitle: translation.filter_items_condition, onTap: () {}),
            InkAccordionItem(
                rawTitle: translation.filter_items_type, onTap: () {})
          ],
        ),
      ],
    );
  }
}
