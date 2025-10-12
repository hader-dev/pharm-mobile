import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/spacers/dividers.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/medical/provider.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/common/filters_button_medical.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/common/filters_button_parapharm.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/quick_apply/medical/quick_apply_filter_medical.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/quick_apply/medical/quick_apply_price_filter_medical.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/widget/search_filter_bottom_sheet.dart';
import 'package:hader_pharm_mobile/models/medical_filters.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class FiltersBar extends StatelessWidget {
  const FiltersBar({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
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
                      filterKey: MedicalFiltersKeys.dci,
                    )),
                  );
                },
              ),
              const ResponsiveGap.s4(),
              FiltersButtonMedical.price(
                localization: translation,
                onPressed: () {
                  BottomSheetHelper.showCommonBottomSheet(
                    context: context,
                    child: MedicalFilterProvider(
                        child: QuickApplyPriceFilterMedical(
                      title: translation.price_range_ht,
                    )),
                  );
                },
              )
            ],
          ),
        ),
        const ResponsiveGap.s4(),
        BlocBuilder<MedicineProductsCubit, MedicineProductsState>(
            builder: (context, state) {
          return Text(
            "${translation.search_results} ${state.totalItemsCount}",
            style: context.responsiveTextTheme.current.bodySmall,
          );
        }),
        const AppDivider.tiny()
      ],
    );
  }
}
