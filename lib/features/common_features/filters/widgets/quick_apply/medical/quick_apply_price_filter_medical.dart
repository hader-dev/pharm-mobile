import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/bottom_sheet_header.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/actions/apply_filters.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/medical/medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/price/filter_price_section.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class QuickApplyPriceFilterMedical extends StatefulWidget {
  const QuickApplyPriceFilterMedical({super.key, required this.title});

  final String title;

  @override
  State<QuickApplyPriceFilterMedical> createState() =>
      _QuickApplyPriceFilterMedicalState();
}

class _QuickApplyPriceFilterMedicalState
    extends State<QuickApplyPriceFilterMedical> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MedicalFiltersCubit>().initializePriceFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BottomSheetHeader(
          title: widget.title,
        ),
        const ResponsiveGap.s12(),
        Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
        const ResponsiveGap.s24(),
        BlocBuilder<MedicalFiltersCubit, MedicalFiltersState>(
          builder: (context, state) {
            final cubit = context.read<MedicalFiltersCubit>();

            final minPrice = cubit.appliedFilters.gteUnitPriceHt != null
                ? double.tryParse(cubit.appliedFilters.gteUnitPriceHt!)
                : null;
            final maxPrice = cubit.appliedFilters.lteUnitPriceHt != null
                ? double.tryParse(cubit.appliedFilters.lteUnitPriceHt!)
                : null;

            return FilterPriceSection(
              key: ValueKey(
                  '${cubit.appliedFilters.gteUnitPriceHt}_${cubit.appliedFilters.lteUnitPriceHt}'),
              minPrice: minPrice,
              maxPrice: maxPrice,
              onChanged: (min, max) => cubit.updatePriceRange(min, max),
              minLimit: 0,
              maxLimit: 10000,
            );
          },
        ),
        const ResponsiveGap.s24(),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
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
                      context.read<MedicalFiltersCubit>().resetPriceFilter();
                    },
                    borderColor: AppColors.accent1Shade1,
                  ),
                ),
                const ResponsiveGap.s8(),
                Expanded(
                  flex: 1,
                  child: PrimaryTextButton(
                    label: context.translation!.confirm,
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
          ),
        ),
      ],
    );
  }
}
