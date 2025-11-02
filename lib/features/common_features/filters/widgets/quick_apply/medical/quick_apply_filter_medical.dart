import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common/widgets/bottom_sheet_header.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/actions/apply_filters.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/medical/medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/common/filter_label.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/common/selected_filters_display.dart';
import 'package:hader_pharm_mobile/models/medical_filters.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class QuickApplyFilterMedical extends StatelessWidget {
  const QuickApplyFilterMedical({
    super.key,
    required this.title,
    this.filterKey = MedicalFiltersKeys.dci,
  });

  final String title;
  final MedicalFiltersKeys filterKey;

  void onFilterSelected(
      String value, bool selected, MedicalFiltersCubit cubit) {
    cubit.updatedAppliedFilters(value, selected);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MedicalFiltersCubit>();

    cubit.updateFilterKey(filterKey);

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BottomSheetHeader(
          title: title,
        ),
        const ResponsiveGap.s12(),
        Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
        const ResponsiveGap.s12(),
        CustomTextField(
          hintText: context.translation!.medicines_search_field_hint,
          controller: cubit.searchController,
          state: FieldState.normal,
          isEnabled: true,
          prefixIcon: Icon(
            Iconsax.search_normal,
            color: AppColors.accent1Shade1,
          ),
          suffixIcon: IconButton(
            onPressed: cubit.clearSearch,
            icon: Icon(
              Icons.clear,
              color: AppColors.accent1Shade1,
            ),
          ),
          onChanged: (text) {
            cubit.onSearchChanged(text ?? '');
          },
          validationFunc: (value) {},
        ),
        BlocBuilder<MedicalFiltersCubit, MedicalFiltersState>(
          builder: (context, state) {
            return SelectedFiltersDisplay(
              selectedFilters: cubit.getCurrentWorkAppliedFilters(),
              onRemoveFilter: (filter) =>
                  onFilterSelected(filter, false, cubit),
            );
          },
        ),
        const ResponsiveGap.s8(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: BlocBuilder<MedicalFiltersCubit, MedicalFiltersState>(
            builder: (context, state) {
              return Scaffold(
                resizeToAvoidBottomInset: true,
                body: SafeArea(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                            maxHeight: constraints.maxHeight,
                          ),
                          child: IntrinsicHeight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    itemCount: cubit
                                        .getCurrentWorkSourceFilters()
                                        .length,
                                    separatorBuilder: (context, index) =>
                                        const ResponsiveGap.s8(),
                                    itemBuilder: (context, index) {
                                      var workingFilters =
                                          cubit.getCurrentWorkSourceFilters();
                                      var filter = workingFilters[index];
                                      var appliedWorkingFilters =
                                          cubit.getCurrentWorkAppliedFilters();
                                      var isSelected = appliedWorkingFilters
                                          .contains(filter);
                                      return FilterLabel(
                                        label: filter,
                                        isSelected: isSelected,
                                        onSelected: (v, s) =>
                                            onFilterSelected(v, s, cubit),
                                      );
                                    },
                                  ),
                                ),
                                Divider(
                                    color: AppColors.bgDisabled,
                                    thickness: 1,
                                    height: 1),
                                const ResponsiveGap.s12(),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                bottomNavigationBar: SafeArea(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
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
                              cubit.resetCurrentFilters();
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
              );
            },
          ),
        ),
      ],
    );
  }
}
