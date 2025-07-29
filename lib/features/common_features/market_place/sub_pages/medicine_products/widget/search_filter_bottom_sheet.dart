import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';

import 'package:hader_pharm_mobile/features/common/widgets/filter_option_value.dart';

import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart' show Iconsax;

import '../../../../../../utils/enums.dart';

import '../../../../../common/buttons/solid/primary_text_button.dart';
import '../../../../../common/widgets/bottom_sheet_header.dart';
import '../../../../../common/widgets/info_widget.dart' show InfoWidget;

import '../../../market_place.dart';
import '../cubit/medicine_products_cubit.dart';

class SearchFilterBottomSheet extends StatelessWidget {
  const SearchFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: MarketPlaceScreen.marketPlaceScaffoldKey.currentContext!.read<MedicineProductsCubit>(),
      child: BlocBuilder<MedicineProductsCubit, MedicineProductsState>(
        builder: (context, state) {
          if (state is! MedicineSearchFilterChanged) {}
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BottomSheetHeader(title: context.translation!.search_filters),
              Gap(AppSizesManager.s12),
              Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
              Gap(AppSizesManager.s12),
              InfoWidget(
                  label: context.translation!.filters,
                  bgColor: AppColors.bgWhite,
                  value: Column(
                    // shrinkWrap: true,
                    children: SearchMedicineFilters.values
                        .map((seachFilter) => FilterOptionValueWidget(
                            title: seachFilter.name,
                            onSelected: () =>
                                BlocProvider.of<MedicineProductsCubit>(context).changeMedicineSearchFilter(seachFilter),
                            isSelected: BlocProvider.of<MedicineProductsCubit>(context).selectedMedicineSearchFilter ==
                                seachFilter))
                        .toList(),
                  )),
              Gap(AppSizesManager.s12),
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
                        labelColor: AppColors.accent1Shade1,
                        onTap: () {
                          BlocProvider.of<MedicineProductsCubit>(context).resetMedicinesSearchFilter();
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
                          BlocProvider.of<MedicineProductsCubit>(context).getMedicines();
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
        },
      ),
    );
  }
}
