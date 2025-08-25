import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/accordions/ink_accordion.dart';
import 'package:hader_pharm_mobile/features/common/accordions/ink_accordion_item.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/actions/get_applied_para_filters_as_raw_string.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/actions/navigate_to_para_filters_apply_view.dart';
import 'package:hader_pharm_mobile/models/para_medical_filters.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class FiltersAccordionParaOthers extends StatelessWidget {
  const FiltersAccordionParaOthers({super.key});

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
              rawTitle: translation.filter_items_code,
              onTap: () => navigateToParaFiltersApplyView(
                  context, ParaMedicalFiltersKeys.code),
              rawSubtitle: getDisplayedParaFiltersAsRawString(
                  context, ParaMedicalFiltersKeys.code),
            ),
            InkAccordionItem(
              rawTitle: translation.filter_items_reimbursement,
              onTap: () => navigateToParaFiltersApplyView(
                  context, ParaMedicalFiltersKeys.reimbursement),
              rawSubtitle: getDisplayedParaFiltersAsRawString(
                  context, ParaMedicalFiltersKeys.reimbursement),
            ),
            InkAccordionItem(
              rawTitle: translation.distributor_sku,
              onTap: () => navigateToParaFiltersApplyView(
                  context, ParaMedicalFiltersKeys.distributorSku),
              rawSubtitle: getDisplayedParaFiltersAsRawString(
                  context, ParaMedicalFiltersKeys.distributorSku),
            ),
          ],
        ),
      ],
    );
  }
}
