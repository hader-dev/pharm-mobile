import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common/widgets/bottom_sheet_header.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/filter_label.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class MedicalFiltersApply extends StatelessWidget {
  const MedicalFiltersApply({
    super.key,
  });


  void onFilterSelected(String value, bool selected,MedicalFiltersCubit cubit) {
    cubit.updatedAppliedFilters(value, selected);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MedicalFiltersCubit>();

    cubit.updateVisibleItems();

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BottomSheetHeader(title: context.translation!.search_filters),
        Gap(AppSizesManager.s12),
        Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
        Gap(AppSizesManager.s12),
        Column(
          children: [
            CustomTextField(
              hintText: context.translation!.medicines_search_field_hint,
              controller: BlocProvider.of<MedicalFiltersCubit>(context)
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
                BlocProvider.of<MedicalFiltersCubit>(context)
                    .updateVisibleItems();
              },
              validationFunc: (value) {},
            ),
            Gap(AppSizesManager.s8),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: BlocBuilder<MedicalFiltersCubit, MedicalFiltersState>(
                  builder: (context, state) {
                return ListView.separated(
                    shrinkWrap: true,
                    itemCount: cubit.getCurrentWorkSourceFilters().length,
                    separatorBuilder: (context, index) => Gap(AppSizesManager.s8),
                    itemBuilder: (context, index) {
                      var workingFilters = cubit.getCurrentWorkSourceFilters();
                      var filter = workingFilters[index];

                      var appliedWorkingFilters = cubit.getCurrentWorkAppliedFilters();
                      var isSelected = appliedWorkingFilters.contains(filter);
              
                      return FilterLabel(label: filter,isSelected:isSelected ,onSelected: (v,s)=>onFilterSelected(v,s,cubit) ,);
                    });
              }),
            )
          ],
        ),
        Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
        Gap(AppSizesManager.s12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p4),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: PrimaryTextButton(
                  label: context.translation!.confirm,
                  leadingIcon: Iconsax.money4,
                  onTap: () {
                    BlocProvider.of<MedicalFiltersCubit>(context)
                        .goToAllFilters();
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
