import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/accordions/ink_accordion.dart';
import 'package:hader_pharm_mobile/features/common/accordions/ink_accordion_item.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class FiltersAccordionOthers extends StatelessWidget {
  const FiltersAccordionOthers({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    return Column(
      children: [
        InkAccordion(
          rawTitle: translation.filters_others,
          isExpanded: false,
          children: [
            InkAccordionItem(
                rawTitle: translation.filter_items_code, onTap: () {}),
            InkAccordionItem(
                rawTitle: translation.filter_items_reimbursement, onTap: () {}),
          ],
        ),
      ],
    );
  }
}
