import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/bottom_sheet_header.dart';
import 'package:hader_pharm_mobile/features/common/widgets/filter_option_value.dart';
import 'package:hader_pharm_mobile/features/common/widgets/info_widget.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/market_place.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/vendors/cubit/vendors_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart' show Iconsax;

class VandorsSearchFilterBottomSheet extends StatelessWidget {
  const VandorsSearchFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: MarketPlaceScreen.marketPlaceScaffoldKey.currentContext!
          .read<VendorsCubit>(),
      child: BlocBuilder<VendorsCubit, VendorsState>(
        builder: (context, state) {
          if (state is! VendorsLoading) {}
          final cubit = BlocProvider.of<VendorsCubit>(context);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BottomSheetHeader(title: context.translation!.search_filters),
              const ResponsiveGap.s12(),
              Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
              const ResponsiveGap.s12(),
              InfoWidget(
                  label: context.translation!.filters,
                  bgColor: AppColors.bgWhite,
                  value: Column(
                    children: SearchVendorFilters.values
                        .map((seachFilter) => FilterOptionValueWidget(
                            title: seachFilter.name,
                            onSelected: () =>
                                cubit.changeVendorsSearchFilter(seachFilter),
                            isSelected: state.selectedVendorSearchFilter ==
                                seachFilter))
                        .toList(),
                  )),
              const ResponsiveGap.s12(),
              Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
              const ResponsiveGap.s12(),
              InfoWidget(
                  label: context.translation!.types,
                  bgColor: AppColors.bgWhite,
                  value: Column(
                    children: DistributorCategory.values
                        .map((seachFilter) => FilterOptionValueWidget(
                            title: seachFilter.name,
                            onSelected: () => cubit
                                .changeDistributorsCategoryFilter(seachFilter),
                            isSelected: state.selectedDistributorTypeFilter ==
                                seachFilter))
                        .toList(),
                  )),
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
                          cubit.resetSearchFilters();
                          context.pop(context);
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
                          cubit.fetchVendors();
                          context.pop(context);
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
