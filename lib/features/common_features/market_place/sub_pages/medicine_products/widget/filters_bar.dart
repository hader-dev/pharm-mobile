import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/spacers/dividers.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';

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
    final cubit = context.read<MedicineProductsCubit>();
    //final filtersCubit = context.read<MedicalFiltersCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // FiltersButtonParapharm.filters(
              //   isActive: cubit.state.hasActiveFilters,
              //   localization: translation,
              //   onPressed: () {
              //     BottomSheetHelper.showCommonBottomSheet(
              //       context: context,
              //       child: SearchMedicineFilterBottomSheet(),
              //     );
              //   },
              // ),
              const ResponsiveGap.s4(),
              // FiltersButtonMedical.dci(
              //   isActive: cubit.state.params.dci.isNotEmpty,
              //   localization: translation,
              //   onPressed: () {
              //     BottomSheetHelper.showCommonBottomSheet(
              //       context: context,
              //       child: MedicalFilterProvider(
              //           child: QuickApplyFilterMedical(
              //         title: translation.filter_items_dci,
              //         filterKey: MedicalFiltersKeys.dci,
              //       )),
              //     );
              //   },
              // ),
              const ResponsiveGap.s4(),
              // FiltersButtonMedical.price(
              //   localization: translation,
              //   isActive: cubit.state.params.gteUnitPriceHt != null ||
              //       cubit.state.params.lteUnitPriceHt != null,
              //   onPressed: () {
              //     BottomSheetHelper.showCommonBottomSheet(
              //       context: context,
              //       child: MedicalFilterProvider(
              //           child: QuickApplyPriceFilterMedical(
              //         title: translation.price_range_ht,
              //       )),
              //     );
              //   },
              // ),
              // const ResponsiveGap.s4(),
              // FiltersButtonMedical.clear(
              //   isActive: cubit.state.hasActiveFilters,
              //   localization: translation,
              //   onPressed: () {
              //     cubit.resetMedicinesSearchFilter();
              //     filtersCubit.resetAllFilters();
              //   },
              // ),
            ],
          ),
        ),
        const ResponsiveGap.s4(),
        BlocBuilder<MedicineProductsCubit, MedicineProductsState>(builder: (context, state) {
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
