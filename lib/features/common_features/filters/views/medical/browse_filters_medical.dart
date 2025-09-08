import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/bottom_sheet_header.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/actions/apply_filters.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/medical/medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/medical/filters_clinical.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/medical/filters_commercial.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/medical/filters_logistics.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/medical/filters_others.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/medical/filters_regulatory.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/price/filter_price_section.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class FiltersMedicalBrowse extends StatelessWidget {
  const FiltersMedicalBrowse({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicalFiltersCubit, MedicalFiltersState>(
        builder: (context, state) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BottomSheetHeader(title: context.translation!.search_filters),
          const ResponsiveGap.s12(),
          Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
          const ResponsiveGap.s12(),
          Column(
            children: [
              FiltersAccordionClinical(),
              FiltersAccordionCommercial(),
              FiltersAccordionRegulatory(),
              FiltersAccordionLogistics(),
              FiltersAccordionOthers()
            ],
          ),
          const ResponsiveGap.s12(),
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
                minLimit: 0,
                maxLimit: 100000,
              );
            },
          ),
          Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
          const ResponsiveGap.s12(),
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
                const ResponsiveGap.s8(),
                Expanded(
                  flex: 2,
                  child: PrimaryTextButton(
                    label: context.translation!.apply,
                    leadingIcon: Iconsax.money4,
                    onTap: () {
                      applyFiltersMedical(context);
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
    });
  }
}
