import 'package:flutter/widgets.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/parapharm/provider.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/common/filters_button_parapharm.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/quick_apply/quick_apply_filter_parapharm.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/widget/search_filter_bottom_sheet.dart';
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
              child: SearchParaPharmFilterBottomSheet(),
            );
          },
        ),
        const ResponsiveGap.s4(),
        FiltersButtonParapharm.name(
          localization: translation,
          onPressed: () {
            BottomSheetHelper.showCommonBottomSheet(
              context: context,
              child: ParaPharmFilterProvider(
                  child: QuickApplyFilterParapharm(
                title: translation.filter_items_name,
              )),
            );
          },
        )
      ],
    );
  }
}
