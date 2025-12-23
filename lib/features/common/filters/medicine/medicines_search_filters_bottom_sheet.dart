import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext, BlocProvider, MultiBlocProvider;
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart' show PrimaryTextButton;
import 'package:hader_pharm_mobile/features/common/filters/medicine/widget/filter_price_section.dart';

import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart' show ResponsiveGap;
import 'package:hader_pharm_mobile/features/common/widgets/bottom_sheet_header.dart' show BottomSheetHeader;
import 'package:hader_pharm_mobile/features/common/widgets/info_widget.dart' show InfoWidget;
import 'package:hader_pharm_mobile/features/common_features/market_place/market_place.dart' show MarketPlaceScreen;

import 'package:hader_pharm_mobile/utils/enums.dart' show SearchMedicinesByFields;
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../models/medicines_filters.dart' show MedicinesFilters;
import '../../../common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import 'cubit/medicines_filters_cubit.dart' show MedicinesFiltersCubit, MedicinesFiltersState;

class MedicinesSearchFiltersBottomSheet extends StatelessWidget {
  final MedicinesFilters? initialFilters;
  const MedicinesSearchFiltersBottomSheet({
    super.key,
    this.initialFilters,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MedicinesFiltersCubit()..initFilters(initialFilters ?? MedicinesFilters()),
        ),
        BlocProvider.value(
          value: MarketPlaceScreen.marketPlaceScaffoldKey.currentContext!.read<MedicineProductsCubit>(),
        ),
      ],
      child: BlocBuilder<MedicinesFiltersCubit, MedicinesFiltersState>(
        builder: (context, state) {
          MedicinesFiltersCubit cubit = context.read<MedicinesFiltersCubit>();
          return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BottomSheetHeader(title: context.translation!.search_filters),
              const ResponsiveGap.s12(),
              Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
              const ResponsiveGap.s12(),
              InfoWidget(
                label: context.translation!.search_by,
                bgColor: AppColors.bgWhite,
                value: Wrap(
                    direction: Axis.horizontal,
                    spacing: context.responsiveAppSizeTheme.current.p8,
                    runSpacing: context.responsiveAppSizeTheme.current.p4,
                    children: SearchMedicinesByFields.values
                        .map((e) => Theme(
                              data: Theme.of(context).copyWith(
                                chipTheme: ChipThemeData(
                                  selectedColor: Colors.green,
                                  backgroundColor: Colors.grey.shade300,
                                  secondarySelectedColor: Colors.green,
                                  pressElevation: 0,
                                  labelStyle: const TextStyle(color: Colors.black),
                                  secondaryLabelStyle: const TextStyle(color: Colors.white),
                                  surfaceTintColor: Colors.transparent,
                                ),
                              ),
                              child: ChoiceChip(
                                  selected: cubit.tempFilters.searchByFields == e,
                                  label: Text(e.name),
                                  elevation: 0,
                                  selectedColor: AppColors.accent1Shade1.withAlpha(120),
                                  selectedShadowColor: AppColors.accent1Shade1.withAlpha(120),
                                  surfaceTintColor: Colors.transparent,
                                  onSelected: (isSelected) {
                                    cubit.changeFilters(cubit.tempFilters.copyWith(searchByField: e));
                                  }),
                            ))
                        .toList()),
              ),
              const ResponsiveGap.s12(),
              const ResponsiveGap.s12(),
              FilterPriceSection(
                minPrice: cubit.tempFilters.minPriceFilter,
                maxPrice: cubit.tempFilters.maxPriceFilter,
              ),
              const Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
              const ResponsiveGap.s12(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.responsiveAppSizeTheme.current.p4),
                child: Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<MedicineProductsCubit, MedicineProductsState>(
                        builder: (context, state) {
                          return PrimaryTextButton(
                            isOutLined: true,
                            label: context.translation!.reset,
                            spalshColor: AppColors.accent1Shade1.withAlpha(50),
                            labelColor: AppColors.accent1Shade1,
                            onTap: () {
                              cubit.resetFilters();
                              context.read<MedicineProductsCubit>().resetMedicinesSearchFilter();

                              context.pop();
                            },
                            borderColor: AppColors.accent1Shade1,
                          );
                        },
                      ),
                    ),
                    const ResponsiveGap.s8(),
                    Expanded(
                      child: BlocBuilder<MedicineProductsCubit, MedicineProductsState>(builder: (context, state) {
                        return PrimaryTextButton(
                          label: context.translation!.apply,
                          leadingIcon: Iconsax.money4,
                          onTap: () {
                            cubit.applyFilters();
                            context.read<MedicineProductsCubit>().updatedFilters(cubit.appliedFilters);
                            context.pop();
                          },
                          color: AppColors.accent1Shade1,
                        );
                      }),
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
