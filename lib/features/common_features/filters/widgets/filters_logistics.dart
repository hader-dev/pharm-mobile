import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/accordions/ink_accordion.dart';
import 'package:hader_pharm_mobile/features/common/accordions/ink_accordion_item.dart';
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
                rawTitle: translation.filter_items_stability_duration, onTap: () {}),
            InkAccordionItem(
                rawTitle: translation.filter_items_origin_country, onTap: () {}),
            InkAccordionItem(
                rawTitle: translation.filter_items_packaging_format, onTap: () {})
          ],
        ),
      ],
    );
  }
}
