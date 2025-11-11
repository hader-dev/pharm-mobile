import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/bottom_sheet_header.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/actions/apply_filters.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/parapharm/para_medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/price/filter_price_section.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class QuickApplyPriceFilterParapharm extends StatelessWidget {
  const QuickApplyPriceFilterParapharm({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ParaMedicalFiltersCubit>();

    cubit.loadParaMedicalFilters();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BottomSheetHeader(
          title: title,
        ),
        const ResponsiveGap.s12(),
        const Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
        const ResponsiveGap.s24(),
        BlocBuilder<ParaMedicalFiltersCubit, ParaMedicalFiltersState>(
          builder: (context, state) {
            final cubit = context.read<ParaMedicalFiltersCubit>();
            final valueKey = ValueKey(
                '${state.appliedFilters.gteUnitPriceHt ?? 'null'}_${state.appliedFilters.lteUnitPriceHt ?? 'null'}');
            return FilterPriceSection(
              key: valueKey,
              minPrice: double.tryParse(
                      state.appliedFilters.gteUnitPriceHt ?? "0.0") ??
                  0,
              maxPrice: double.tryParse(
                      state.appliedFilters.lteUnitPriceHt ?? "10000") ??
                  10000,
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
                      context
                          .read<ParaMedicalFiltersCubit>()
                          .resetPriceFilter();
                      context.pop();
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
                      applyFiltersParaPharm(context);
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
