import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/spacers/dividers.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart' show CustomTextField;
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../deligate_marketplace/sub_pages/para_pharma/widget/search_filter_bottom_sheet.dart'
    show SearchParaPharmFilterBottomSheet;

class FiltersBarV2 extends StatelessWidget {
  const FiltersBarV2({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    final cubit = context.read<ParaPharmaCubit>();

    return BlocBuilder<ParaPharmaCubit, ParaPharmaState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Expanded(
              child: Transform.scale(
                alignment: Alignment.centerLeft,
                scale: 0.95,
                child: CustomTextField(
                  verticalPadding: context.responsiveAppSizeTheme.current.s2,
                  controller: state.searchController,
                  suffixIcon: state.searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: context.theme.colorScheme.onSurfaceVariant),
                          onPressed: () {
                            state.searchController.clear();
                            cubit.searchParaPharmaCatalog("");
                          },
                        )
                      : null,
                  onChanged: (value) {
                    cubit.searchParaPharmaCatalog(value);
                  },
                  hintText: "Search para pharmas ...",
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
                    child: SearchParaPharmFilterBottomSheet(),
                  );
                },
                // BottomSheetHelper.showCommonBottomSheet(
                //     context: context, child: FiltersBottomSheet(), initialChildSize: 0.6, maxHeight: 0.65),
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
                      // if (state.filters.createdAtFrom.isNotEmpty ||
                      //     state.filters.createdAtTo.isNotEmpty ||
                      //     state.filters.status.isNotEmpty)
                      //   Positioned(
                      //     right: -5,
                      //     top: 0,
                      //     child: Container(
                      //       width: 8,
                      //       height: 8,
                      //       decoration: BoxDecoration(
                      //         color: AppColors.accent1Shade1,
                      //         shape: BoxShape.circle,
                      //       ),
                      //     ),
                      //   ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );

        // Column(
        //   mainAxisSize: MainAxisSize.min,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       "${translation.search_results} ${state.totalItemsCount}",
        //       style: context.responsiveTextTheme.current.bodySmall,
        //     ),
        //     AppDivider(
        //       color: Colors.grey.shade100,
        //       indent: context.responsiveAppSizeTheme.current.p8,
        //       endIndent: context.responsiveAppSizeTheme.current.p8,
        //     )
        //   ],
        // );
      },
    );
  }
}
