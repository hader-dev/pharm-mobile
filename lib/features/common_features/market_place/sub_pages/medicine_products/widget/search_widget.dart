import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/widget/search_filter_bottom_sheet.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(
                left: context.responsiveAppSizeTheme.current.p8),
            child: CustomTextField(
              hintText: context.translation!.medicines_search_field_hint,
              controller:
                  context.read<MedicineProductsCubit>().state.searchController,
              state: FieldState.normal,
              isEnabled: true,
              prefixIcon: Icon(
                Iconsax.search_normal,
                size: context.responsiveAppSizeTheme.current.iconSize20,
                color: AppColors.accent1Shade1,
              ),
              suffixIcon: InkWell(
                onTap: () {
                  context
                      .read<MedicineProductsCubit>()
                      .state
                      .searchController
                      .clear();
                  BlocProvider.of<MedicineProductsCubit>(context)
                      .searchMedicineCatalog(null);
                },
                child: Icon(
                  Icons.clear,
                  color: AppColors.accent1Shade1,
                ),
              ),
              onChanged: (searchValue) {
                BlocProvider.of<MedicineProductsCubit>(context)
                    .searchMedicineCatalog(searchValue);
              },
              validationFunc: (value) {},
            ),
          ),
        ),
        InkWell(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: context.responsiveAppSizeTheme.current.p12),
            child: BlocBuilder<MedicineProductsCubit, MedicineProductsState>(
              builder: (context, state) {
                return BlocBuilder<MedicineProductsCubit,
                    MedicineProductsState>(
                  builder: (context, state) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(
                          Iconsax.filter,
                          color: AppColors.accent1Shade1,
                        ),
                        if (state.selectedMedicineSearchFilter !=
                            SearchMedicineFilters.dci)
                          Positioned(
                            top: -4,
                            right: -4,
                            child: CircleAvatar(
                              radius: context.responsiveAppSizeTheme.current
                                  .commonWidgetsRadius,
                              backgroundColor: Colors.red,
                            ),
                          )
                      ],
                    );
                  },
                );
              },
            ),
          ),
          onTap: () {
            BottomSheetHelper.showCommonBottomSheet(
                context: context, child: SearchMedicineFilterBottomSheet());
          },
        ),
      ],
    );
  }
}
