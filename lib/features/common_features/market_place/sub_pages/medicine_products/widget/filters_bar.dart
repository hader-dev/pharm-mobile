import 'package:flutter/widgets.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/medical/provider.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/common/filters_button_medical.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/common/filters_button_parapharm.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/quick_apply/quick_apply_filter_medical.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/widget/search_filter_bottom_sheet.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class FiltersBar extends StatelessWidget {
  const FiltersBar({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return Row(
      children: [
        FiltersButtonParapharm.filters(
          localization: translation,
          onPressed: () {
            BottomSheetHelper.showCommonBottomSheet(
              context: context,
              child: SearchMedicineFilterBottomSheet(),
            );
          },
        ),
        const ResponsiveGap.s4(),
        FiltersButtonMedical.dci(
          localization: translation,
          onPressed: () {
            BottomSheetHelper.showCommonBottomSheet(
              context: context,
              child: MedicalFilterProvider(
                  child: QuickApplyFilterMedical(
                title: translation.filter_items_dci,
              )),
            );
          },
        )
      ],
    );
  }
}
