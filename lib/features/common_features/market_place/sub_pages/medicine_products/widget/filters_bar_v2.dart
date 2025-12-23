import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/spacers/dividers.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart' show CustomTextField;
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart'
    show MedicineProductsCubit, MedicineProductsState;
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:lucide_icons/lucide_icons.dart' show LucideIcons;

import '../../../../../../config/theme/colors_manager.dart' show AppColors;
import '../../../../../../utils/bottom_sheet_helper.dart' show BottomSheetHelper;
import '../../../../../common/filters/medicine/medicines_search_filters_bottom_sheet.dart'
    show MedicinesSearchFiltersBottomSheet;

class FiltersBarV2 extends StatelessWidget {
  const FiltersBarV2({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    final cubit = context.read<MedicineProductsCubit>();

    return BlocBuilder<MedicineProductsCubit, MedicineProductsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Expanded(
                  child: Transform.scale(
                    alignment: Alignment.center,
                    scale: 0.95,
                    child: CustomTextField(
                      controller: state.searchController,
                      suffixIcon: state.searchController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear, color: context.theme.colorScheme.onSurfaceVariant),
                              onPressed: () {
                                state.searchController.clear();
                                cubit.searchMedicineCatalog("");
                              },
                            )
                          : null,
                      onChanged: (value) {
                        cubit.searchMedicineCatalog(value);
                      },
                      hintText: "Search ${translation.medicines} ...",
                      hintTextStyle: context.responsiveTextTheme.current.body1Regular.copyWith(color: Colors.grey),
                      prefixIcon: Icon(Icons.search, color: context.theme.colorScheme.onSurfaceVariant),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p4),
                  child: InkWell(
                    onTap: () {
                      BottomSheetHelper.showCommonBottomSheet(
                        context: context,
                        child: MedicinesSearchFiltersBottomSheet(
                          initialFilters: state.filters,
                        ),
                      );
                    },
                    child: SizedBox(
                      width: context.responsiveAppSizeTheme.current.iconSize25,
                      height: context.responsiveAppSizeTheme.current.iconSize25,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            LucideIcons.filter,
                            color: context.theme.colorScheme.onSurfaceVariant,
                            size: context.responsiveAppSizeTheme.current.iconSize20,
                          ),
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
            AppDivider(
              color: Colors.grey.shade100,
              indent: context.responsiveAppSizeTheme.current.p8,
              endIndent: context.responsiveAppSizeTheme.current.p8,
            )
          ],
        );
      },
    );
  }
}
