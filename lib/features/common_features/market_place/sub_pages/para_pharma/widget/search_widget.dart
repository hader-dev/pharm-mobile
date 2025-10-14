import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/widget/search_filter_bottom_sheet.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<ParaPharmaCubit>().state;
    return Row(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: AppSizesManager.p8),
            child: CustomTextField(
              hintText: context.translation!.search_by_name_packaging_sku,
              controller: state.searchController,
              state: FieldState.normal,
              isEnabled: true,
              prefixIcon: Icon(
                Iconsax.search_normal,
                color: AppColors.accent1Shade1,
              ),
              suffixIcon: InkWell(
                onTap: () {
                  state.searchController.clear();
                  BlocProvider.of<ParaPharmaCubit>(context)
                      .searchParaPharmaCatalog(null);
                },
                child: Icon(
                  Icons.clear,
                  color: AppColors.accent1Shade1,
                ),
              ),
              onChanged: (searchValue) {
                BlocProvider.of<ParaPharmaCubit>(context)
                    .searchParaPharmaCatalog(searchValue);
              },
              validationFunc: (value) {},
            ),
          ),
        ),
        InkWell(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSizesManager.p12),
            child: BlocBuilder<ParaPharmaCubit, ParaPharmaState>(
              builder: (context, state) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      Iconsax.filter,
                      color: AppColors.accent1Shade1,
                    ),
                    if (state.filters.isNotEmpty)
                      Positioned(
                        top: -4,
                        right: -4,
                        child: CircleAvatar(
                          radius: AppSizesManager.commonWidgetsRadius,
                          backgroundColor: Colors.red,
                        ),
                      )
                  ],
                );
              },
            ),
          ),
          onTap: () {
            BottomSheetHelper.showCommonBottomSheet(
              context: context,
              child: SearchParaPharmFilterBottomSheet(),
            );
          },
        ),
      ],
    );
  }
}
