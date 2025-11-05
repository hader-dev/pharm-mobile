import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/spacers/dividers.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/orders/orders_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/orders/provider.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/common/filters_button_order.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/quick_apply/orders/quick_apply_date_filter.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/quick_apply/orders/quick_apply_filter.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/cubit/orders_cubit.dart';
import 'package:hader_pharm_mobile/models/order_filters.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class FiltersBar extends StatelessWidget {
  const FiltersBar({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    final cubit = context.read<OrdersCubit>();
    final filtersCubit = context.read<OrdersFiltersCubit>();

    return Padding(
      padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
      child: BlocBuilder<OrdersCubit, OrdersState>(
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
                            // FiltersButtonOrder.filters(
                            //   isActive: state.hasActiveFilters,
                            //   localization: translation,
                            //   onPressed: () {
                            //     BottomSheetHelper.showCommonBottomSheet(
                            //       context: context,
                            //       child: SearchParaPharmFilterBottomSheet(),
                            //     );
                            //   },
                            // ),
                            // const ResponsiveGap.s4(),
                            FiltersButtonOrder.status(
                              isActive: state.filters.status.isNotEmpty,
                              localization: translation,
                              onPressed: () {
                                BottomSheetHelper.showCommonBottomSheet(
                                  context: context,
                                  child: OrderFilterProvider(
                                    child: QuickApplyFilterOrder(
                                      title: translation.filter_items_status,
                                      filterKey: OrderFiltersKeys.status,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const ResponsiveGap.s4(),
                            FiltersButtonOrder.from(
                              isActive: state.filters.createdAtFrom.isNotEmpty,
                              localization: translation,
                              onPressed: () {
                                BottomSheetHelper.showCommonBottomSheet(
                                  context: context,
                                  child: OrderFilterProvider(
                                    child: QuickApplyFilterDateOrder(
                                      title: translation.filter_items_from,
                                      filterKey: OrderFiltersKeys.createdAtFrom,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const ResponsiveGap.s4(),
                            FiltersButtonOrder.to(
                              isActive: state.filters.createdAtTo.isNotEmpty,
                              localization: translation,
                              onPressed: () {
                                BottomSheetHelper.showCommonBottomSheet(
                                  context: context,
                                  child: OrderFilterProvider(
                                    child: QuickApplyFilterDateOrder(
                                      title: translation.filter_items_to,
                                      filterKey: OrderFiltersKeys.createdAtTo,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const ResponsiveGap.s4(),
                            FiltersButtonOrder.clear(
                              isActive: state.hasActiveFilters,
                              localization: translation,
                              onPressed: () {
                                cubit.resetOrderFilters();
                                filtersCubit.resetAllFilters();
                              },
                            )
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
      ),
    );
  }
}
