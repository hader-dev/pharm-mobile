import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/widgets/bottom_sheet_header.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/para_medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/filters_para_clinical.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/filters_para_regulatory.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/filters_para_commercial.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/filters_para_logistics.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/filters_para_others.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class FiltersParaMedicalBrowse extends StatelessWidget {
  const FiltersParaMedicalBrowse({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParaMedicalFiltersCubit, ParaMedicalFiltersState>(
      builder: (context, state) {
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
                // TODO: Uncomment when backend is ready
                // FiltersAccordionParaPharmaSpecific(),

                FiltersAccordionParaClinical(),

                FiltersAccordionParaRegulatory(),

                FiltersAccordionParaCommercial(),

                FiltersAccordionParaLogistics(),

                FiltersAccordionParaOthers(),
              ],
            ),

            Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
            Gap(AppSizesManager.s12),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p4),
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
                        final cubit = context.read<ParaMedicalFiltersCubit>();
                        cubit.resetFilters();
                        context.pop();
                      },
                      borderColor: AppColors.accent1Shade1,
                    ),
                  ),
                  Gap(AppSizesManager.s8),

                  Expanded(
                    flex: 2,
                    child: PrimaryTextButton(
                      label: context.translation!.apply,
                      leadingIcon: Iconsax.money4,
                      onTap: () {
                        final appliedFilters =
                            context.read<ParaMedicalFiltersCubit>().appliedFilters;
                        final paraPharmaCubit =
                            context.read<ParaPharmaCubit>();
                        paraPharmaCubit.updatedFilters(appliedFilters);
                        paraPharmaCubit.getParaPharmas();

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
    );
  }
}
