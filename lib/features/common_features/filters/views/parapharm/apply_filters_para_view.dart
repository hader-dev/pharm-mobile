import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common/widgets/bottom_sheet_header.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/para_medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/filter_label.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/selected_filters_display.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class ParaMedicalFiltersApply extends StatelessWidget {
  const ParaMedicalFiltersApply({super.key});

  void onFilterSelected(
      String value, bool selected, ParaMedicalFiltersCubit cubit) {
    cubit.updatedAppliedFilters(value, selected);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ParaMedicalFiltersCubit>();

    cubit.loadParaMedicalFilters();

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                BlocProvider.of<ParaMedicalFiltersCubit>(context)
                    .goToAllFilters();
              },
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.accent1Shade1,
              ),
            ),
            Expanded(
              child: BottomSheetHeader(
                title: context.translation!.search_filters,
              ),
            ),
          ],
        ),
        Gap(AppSizesManager.s12),
        Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
        Gap(AppSizesManager.s12),
        CustomTextField(
          hintText: context.translation!.medicines_search_field_hint,
          controller: BlocProvider.of<ParaMedicalFiltersCubit>(context)
              .searchController,
          state: FieldState.normal,
          isEnabled: true,
          prefixIcon: Icon(
            Iconsax.search_normal,
            color: AppColors.accent1Shade1,
          ),
          suffixIcon: Icon(
            Icons.clear,
            color: AppColors.accent1Shade1,
          ),
          onChanged: (searchValue) {
            BlocProvider.of<ParaMedicalFiltersCubit>(context)
                .loadParaMedicalFilters();
          },
          validationFunc: (value) {},
        ),
        BlocBuilder<ParaMedicalFiltersCubit, ParaMedicalFiltersState>(
          builder: (context, state) {
            return SelectedFiltersDisplay(
              selectedFilters: cubit.getCurrentWorkAppliedFilters(),
              onRemoveFilter: (filter) =>
                  onFilterSelected(filter, false, cubit),
            );
          },
        ),
        Gap(AppSizesManager.s8),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: BlocBuilder<ParaMedicalFiltersCubit, ParaMedicalFiltersState>(
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
                                  child: BlocBuilder<ParaMedicalFiltersCubit,
                                      ParaMedicalFiltersState>(
                                    builder: (context, state) {
                                      return ListView.separated(
                                        padding: EdgeInsets.zero,
                                        itemCount: cubit
                                            .getCurrentWorkSourceFilters()
                                            .length,
                                        separatorBuilder: (context, index) =>
                                            Gap(AppSizesManager.s8),
                                        itemBuilder: (context, index) {
                                          var workingFilters = cubit
                                              .getCurrentWorkSourceFilters();
                                          var filter = workingFilters[index];
                                          var appliedWorkingFilters = cubit
                                              .getCurrentWorkAppliedFilters();
                                          var isSelected = appliedWorkingFilters
                                              .contains(filter);
                                          return FilterLabel(
                                            label: filter,
                                            isSelected: isSelected,
                                            onSelected: (v, s) =>
                                                onFilterSelected(v, s, cubit),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                                Divider(
                                    color: AppColors.bgDisabled,
                                    thickness: 1,
                                    height: 1),
                                Gap(AppSizesManager.s12),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 12.0),
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
                              BlocProvider.of<ParaMedicalFiltersCubit>(context)
                                  .resetCurrentFilters();
                            },
                            borderColor: AppColors.accent1Shade1,
                          ),
                        ),
                        Gap(AppSizesManager.s8),
                        Expanded(
                          flex: 2,
                          child: PrimaryTextButton(
                            label: context.translation!.confirm,
                            leadingIcon: Iconsax.money4,
                            onTap: () {
                              BlocProvider.of<ParaMedicalFiltersCubit>(context)
                                  .goToAllFilters();
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
