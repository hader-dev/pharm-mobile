import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/accordions/ink_accordion_item.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/widgets/bottom_sheet_header.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/actions/get_applied_filters_as_raw_string.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/actions/navigate_to_medical_filters_apply_view.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/filter_price_section.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import 'package:hader_pharm_mobile/models/medical_filters.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class FiltersMedicalBrowse extends StatelessWidget {
  const FiltersMedicalBrowse({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicalFiltersCubit, MedicalFiltersState>(
      builder: (context,state) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BottomSheetHeader(title: context.translation!.search_filters),
            Gap(AppSizesManager.s12),
            Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
            Gap(AppSizesManager.s12),
            Column(
              children: [
                InkAccordionItem(
                  rawTitle: context.translation!.filter_items_dci,
                  onTap: () => navigateToMedicalFiltersApplyView(context, MedicalFiltersKeys.dci),
                  rawSubtitle: getDisplayedFiltersAsRawString(context, MedicalFiltersKeys.dci),
                ),
                InkAccordionItem(
                  rawTitle: context.translation!.filter_items_distributor_sku,
                  onTap: () => navigateToMedicalFiltersApplyView(context, MedicalFiltersKeys.distributorSku),
                  rawSubtitle: getDisplayedFiltersAsRawString(context, MedicalFiltersKeys.distributorSku),
                ),
                InkAccordionItem(
                  rawTitle: context.translation!.filter_items_code,
                  onTap: () => navigateToMedicalFiltersApplyView(context, MedicalFiltersKeys.code),
                  rawSubtitle: getDisplayedFiltersAsRawString(context, MedicalFiltersKeys.code),
                ),

              ],
            ),
            Gap(AppSizesManager.s12),
            BlocBuilder<MedicalFiltersCubit, MedicalFiltersState>(
              builder: (context, state) {
                final cubit = context.read<MedicalFiltersCubit>();
                return FilterPriceSection(
                  minPrice: cubit.appliedFilters.gteUnitPriceHt != null
                      ? double.tryParse(cubit.appliedFilters.gteUnitPriceHt!)
                      : null,
                  maxPrice: cubit.appliedFilters.lteUnitPriceHt != null
                      ? double.tryParse(cubit.appliedFilters.lteUnitPriceHt!)
                      : null,
                  onChanged: (min, max) => cubit.updatePriceRange(min, max),
                );
              },
            ),
            Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
            Gap(AppSizesManager.s12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p4),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: PrimaryTextButton(
                      isOutLined: true,
                      label: context.translation!.reset,
                      spalshColor: AppColors.accent1Shade1.withAlpha(50),
                      labelColor: AppColors.accent1Shade1,
                      onTap: () {
                        context.read<MedicalFiltersCubit>().resetAllFilters();

                        BlocProvider.of<MedicineProductsCubit>(context)
                            .resetMedicinesSearchFilter();
                      },
                      borderColor: AppColors.accent1Shade1,
                    ),
                  ),
                  Gap(AppSizesManager.s8),
                  Expanded(
                    flex: 2,
                    child: PrimaryTextButton(
                      label: context.translation!.apply,
                      leadingIcon: Iconsax.money4,
                      onTap: () {
                        final appliedFilters =
                            context.read<MedicalFiltersCubit>().appliedFilters;
                        final medicineCatalogCubit =
                            context.read<MedicineProductsCubit>();
                        medicineCatalogCubit.updatedFilters(appliedFilters);
                        medicineCatalogCubit.getMedicines();
        
                        context.pop();
                      },
                      color: AppColors.accent1Shade1,
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }
    );
  }


}
