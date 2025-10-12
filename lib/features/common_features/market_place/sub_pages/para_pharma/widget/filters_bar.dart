import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/spacers/dividers.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/parapharm/provider.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/common/filters_button_parapharm.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/quick_apply/parapharm/quick_apply_filter_parapharm.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/quick_apply/parapharm/quick_apply_price_filter_parapharm.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/widget/search_filter_bottom_sheet.dart';
import 'package:hader_pharm_mobile/models/para_medical_filters.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class FiltersBar extends StatelessWidget {
  const FiltersBar({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    return BlocBuilder<ParaPharmaCubit, ParaPharmaState>(
      buildWhen: (prev, curr) =>
          (prev.displayFilters != curr.displayFilters) ||
          (prev.totalItemsCount != curr.totalItemsCount),
      builder: (context, state) {
        return AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          child: state.displayFilters
              ? Column(
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
                                    filterKey: ParaMedicalFiltersKeys.name,
                                  ),
                                ),
                              );
                            },
                          ),
                          const ResponsiveGap.s4(),
                          FiltersButtonParapharm.price(
                            localization: translation,
                            onPressed: () {
                              BottomSheetHelper.showCommonBottomSheet(
                                context: context,
                                child: ParaPharmFilterProvider(
                                  child: QuickApplyPriceFilterParapharm(
                                    title: translation.price_range_ht,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const ResponsiveGap.s4(),
                    Text(
                      "${translation.search_results} ${state.totalItemsCount}",
                      style: context.responsiveTextTheme.current.bodySmall,
                    ),
                    const AppDivider.tiny()
                  ],
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
