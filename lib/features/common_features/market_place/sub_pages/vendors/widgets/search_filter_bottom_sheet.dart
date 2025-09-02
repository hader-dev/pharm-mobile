import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/filter_option_value.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/vendors/cubit/vendors_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart' show Iconsax;

import '../../../../../../utils/enums.dart';
import '../../../../../common/buttons/solid/primary_text_button.dart';
import '../../../../../common/widgets/bottom_sheet_header.dart';
import '../../../../../common/widgets/info_widget.dart' show InfoWidget;
import '../../../market_place.dart';

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
                    // shrinkWrap: true,
                    children: SearchVendorFilters.values
                        .map((seachFilter) => FilterOptionValueWidget(
                            title: seachFilter.name,
                            onSelected: () =>
                                BlocProvider.of<VendorsCubit>(context)
                                    .changeVendorsSearchFilter(seachFilter),
                            isSelected: BlocProvider.of<VendorsCubit>(context)
                                    .selectedVendorSearchFilter ==
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
                    // shrinkWrap: true,
                    children: DistributorCategory.values
                        .map((seachFilter) => FilterOptionValueWidget(
                            title: seachFilter.name,
                            onSelected: () => BlocProvider.of<VendorsCubit>(
                                    context)
                                .changeDistributorsCategoryFilter(seachFilter),
                            isSelected: BlocProvider.of<VendorsCubit>(context)
                                    .selectedDistributorTypeFilter ==
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
                          BlocProvider.of<VendorsCubit>(context)
                              .resetSearchFilters();
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
                          BlocProvider.of<VendorsCubit>(context).fetchVendors();
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
