import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart' show PrimaryTextButton;
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart' show ResponsiveGap;
import 'package:hader_pharm_mobile/features/common/widgets/info_widget.dart' show InfoWidget;
// import 'package:hader_pharm_mobile/features/common_features/filters/actions/apply_filters.dart';
// import 'package:hader_pharm_mobile/features/common_features/filters/cubit/parapharm/provider.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
// import 'package:hader_pharm_mobile/models/para_medical_filters.dart' show ParaMedicalFiltersKeys;
import 'package:hader_pharm_mobile/utils/enums.dart' show ParaPharmSearchByFields;
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/bottom_sheet_header.dart' show BottomSheetHeader;
// import '../../../../filters/cubit/parapharm/para_medical_filters_cubit.dart';
// import '../../../../filters/widgets/price/filter_price_section.dart';

class SearchParaPharmFilterBottomSheet extends StatelessWidget {
  const SearchParaPharmFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
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
              children: ParaPharmSearchByFields.values.map((e) => Chip(label: Text(e.name))).toList()),
        ),
        const ResponsiveGap.s12(),
        // BlocBuilder<ParaMedicalFiltersCubit, ParaMedicalFiltersState>(
        //   builder: (context, state) {
        //     return FilterPriceSection(
        //       minPrice: 0,
        //       maxPrice: 0,
        //     );
        //   },
        // ),
        const Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
        const ResponsiveGap.s12(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.responsiveAppSizeTheme.current.p4),
          child: Row(
            children: [
              Expanded(
                child: PrimaryTextButton(
                  isOutLined: true,
                  label: context.translation!.reset,
                  spalshColor: AppColors.accent1Shade1.withAlpha(50),
                  labelColor: AppColors.accent1Shade1,
                  onTap: () {
                    //context.read<ParaMedicalFiltersCubit>().resetAllFilters();

                    context.read<ParaPharmaCubit>().resetParaPharmaFilters();
                    //  applyFiltersParaPharm(context);
                    context.pop();
                  },
                  borderColor: AppColors.accent1Shade1,
                ),
              ),
              const ResponsiveGap.s8(),
              Expanded(
                child: PrimaryTextButton(
                  label: context.translation!.apply,
                  leadingIcon: Iconsax.money4,
                  onTap: () {
                    //   applyFiltersParaPharm(context);
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
}
