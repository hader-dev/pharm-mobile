import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/spacers/dividers.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart'
    show CustomTextField;
import 'package:hader_pharm_mobile/features/common_features/orders/cubit/orders_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/widget/filter_bottom_sheet.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../config/theme/colors_manager.dart' show AppColors;

class FiltersBar extends StatelessWidget {
  const FiltersBar({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    final cubit = context.read<OrdersCubit>();
    final isFiltersVisible = ValueNotifier<bool>(true);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.responsiveAppSizeTheme.current.p8),
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          return ValueListenableBuilder(
            valueListenable: isFiltersVisible,
            builder: (context, value, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Expanded(
                      child: Transform.scale(
                        scale: 0.95,
                        child: CustomTextField(
                          verticalPadding:
                              context.responsiveAppSizeTheme.current.s2,
                          controller: cubit.searchController,
                          suffixIcon: cubit.searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: Icon(Icons.clear,
                                      color: context
                                          .theme.colorScheme.onSurfaceVariant),
                                  onPressed: () {
                                    cubit.searchController.clear();
                                    cubit.searchOrders("");
                                  },
                                )
                              : null,
                          onChanged: (value) {
                            cubit.searchOrders(value);
                          },
                          hintText: "Search by order reference ...",
                          prefixIcon: Icon(Icons.search,
                              color:
                                  context.theme.colorScheme.onSurfaceVariant),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              context.responsiveAppSizeTheme.current.p8),
                      child: InkWell(
                        onTap: () => BottomSheetHelper.showCommonBottomSheet(
                            context: context,
                            child: FiltersBottomSheet(),
                            initialChildSize: 0.6,
                            maxHeight: 0.65),
                        child: SizedBox(
                          width:
                              context.responsiveAppSizeTheme.current.iconSize25,
                          height:
                              context.responsiveAppSizeTheme.current.iconSize25,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Icon(
                                LucideIcons.filter,
                                color:
                                    context.theme.colorScheme.onSurfaceVariant,
                                size: context
                                    .responsiveAppSizeTheme.current.iconSize20,
                              ),
                              if (state.filters.createdAtFrom.isNotEmpty ||
                                  state.filters.createdAtTo.isNotEmpty ||
                                  state.filters.status.isNotEmpty)
                                Positioned(
                                  right: -5,
                                  top: 0,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: AppColors.accent1Shade1,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${translation.search_results} ${state.totalItemsCount}",
                  style: context.responsiveTextTheme.current.bodySmall,
                ),
                const ResponsiveGap.s2(),
                AppDivider(
                  color: Colors.grey.shade100,
                  indent: context.responsiveAppSizeTheme.current.p8,
                  endIndent: context.responsiveAppSizeTheme.current.p8,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
