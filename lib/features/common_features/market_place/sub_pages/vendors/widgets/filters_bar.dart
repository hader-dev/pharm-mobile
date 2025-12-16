import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/spacers/dividers.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart' show CustomTextField;
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/vendors/cubit/vendors_cubit.dart'
    show VendorsCubit, VendorsState;
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../../../config/theme/colors_manager.dart' show AppColors;
import 'search_filter_bottom_sheet.dart' show VendorsSearchFilterBottomSheet;

class FiltersBar extends StatelessWidget {
  const FiltersBar({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    final cubit = context.read<VendorsCubit>();

    return BlocBuilder<VendorsCubit, VendorsState>(
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
                                cubit.searchVendor(null);
                              },
                            )
                          : null,
                      onChanged: (value) {
                        cubit.searchVendor(state.searchController.text);
                      },
                      hintText: "Search ${translation.vendors} ...",
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
                        child: VendorsSearchFilterBottomSheet(),
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
              "${translation.search_results} ${state.vendorsList.length}",
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
