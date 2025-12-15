import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext, BlocProvider, MultiBlocProvider;
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart' show getItInstance;
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart' show INetworkService;
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart' show PrimaryTextButton;
import 'package:hader_pharm_mobile/features/common/chips/custom_chip.dart';
import 'package:hader_pharm_mobile/features/common/filters/para_pharm/cubit/para_pharm_filters_cubit.dart'
    show ParaPharmFiltersChanged, ParaPharmFiltersCubit, ParaPharmFiltersState;
import 'package:hader_pharm_mobile/features/common/filters/para_pharm/widget/brand_search_filter.dart'
    show BrandSearchFilter;
import 'package:hader_pharm_mobile/features/common/filters/para_pharm/widget/filter_price_section.dart'
    show FilterPriceSection;
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart' show ResponsiveGap;
import 'package:hader_pharm_mobile/features/common/widgets/bottom_sheet_header.dart' show BottomSheetHeader;
import 'package:hader_pharm_mobile/features/common/widgets/info_widget.dart' show InfoWidget;
import 'package:hader_pharm_mobile/features/common_features/market_place/market_place.dart' show MarketPlaceScreen;
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart'
    show ParaPharmaCubit, ParaPharmaState;
import 'package:hader_pharm_mobile/models/para_pharm_filters.dart' show ParaPharmFilters;

import 'package:hader_pharm_mobile/utils/enums.dart' show ParaPharmSearchByFields;
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../repositories/remote/para_pharm_brand/para_pharm_brand_repository_impl.dart'
    show ParaPharmBrandRepository;
import '../../../../repositories/remote/para_pharm_category/para_pharm_category_repository_impl.dart'
    show ParaPharmCategoryRepository;
import 'widget/category_search_filter.dart' show CategorySearchFilter;

class ParaPharmSearchFiltersBottomSheet extends StatelessWidget {
  final ParaPharmFilters? initialFilters;
  const ParaPharmSearchFiltersBottomSheet({
    super.key,
    this.initialFilters,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ParaPharmFiltersCubit(
              paraPharmBrandRepository: ParaPharmBrandRepository(client: getItInstance.get<INetworkService>()),
              paraPharmCategoryRepository: ParaPharmCategoryRepository(client: getItInstance.get<INetworkService>()))
            ..initFilters(initialFilters ?? ParaPharmFilters()),
        ),
        BlocProvider.value(
          value: MarketPlaceScreen.marketPlaceScaffoldKey.currentContext!.read<ParaPharmaCubit>(),
        ),
      ],
      child: BlocBuilder<ParaPharmFiltersCubit, ParaPharmFiltersState>(
        buildWhen: (previous, current) => previous is ParaPharmFiltersChanged,
        builder: (context, state) {
          ParaPharmFiltersCubit cubit = context.read<ParaPharmFiltersCubit>();
          return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BottomSheetHeader(title: context.translation!.search_filters),
              const ResponsiveGap.s12(),
              Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
              const ResponsiveGap.s12(),
              InfoWidget(
                label: "Search By:",
                bgColor: AppColors.bgWhite,
                value: Wrap(
                    direction: Axis.horizontal,
                    spacing: context.responsiveAppSizeTheme.current.p8,
                    runSpacing: context.responsiveAppSizeTheme.current.p4,
                    children: ParaPharmSearchByFields.values
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
                                  selected: cubit.tempFilters.searchByField == e,
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
              BrandSearchFilter(),
              CategorySearchFilter(),
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
                      child: BlocBuilder<ParaPharmaCubit, ParaPharmaState>(
                        builder: (context, state) {
                          return PrimaryTextButton(
                            isOutLined: true,
                            label: context.translation!.reset,
                            spalshColor: AppColors.accent1Shade1.withAlpha(50),
                            labelColor: AppColors.accent1Shade1,
                            onTap: () {
                              cubit.resetFilters();
                              context.read<ParaPharmaCubit>().resetParaPharmaFilters();

                              context.pop();
                            },
                            borderColor: AppColors.accent1Shade1,
                          );
                        },
                      ),
                    ),
                    const ResponsiveGap.s8(),
                    Expanded(
                      child: BlocBuilder<ParaPharmaCubit, ParaPharmaState>(builder: (context, state) {
                        return PrimaryTextButton(
                          label: context.translation!.apply,
                          leadingIcon: Iconsax.money4,
                          onTap: () {
                            cubit.applyFilters();
                            context.read<ParaPharmaCubit>().updatedFilters(cubit.appliedFilters);
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
