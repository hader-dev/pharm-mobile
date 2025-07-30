import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/actions/previous_step_or_logout.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/cubit/create_company_profile_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class NavigationButtonsSection extends StatelessWidget {
  const NavigationButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
      child: Row(
        children: [
          Expanded(
            child: PrimaryTextButton(
              label: BlocProvider.of<CreateCompanyProfileCubit>(context)
                          .currentStepIndex !=
                      0
                  ? context.translation!.previous
                  : context.translation!.cancel,
              labelColor: AppColors.accent1Shade1,
              onTap: () => previousStepOrLogout(context),
              borderColor: AppColors.accent1Shade1,
            ),
          ),
          Gap(AppSizesManager.s8),
          Expanded(
            child: PrimaryTextButton(
              label: BlocProvider.of<CreateCompanyProfileCubit>(context)
                          .currentStepIndex <
                      4
                  ? context.translation!.next
                  : context.translation!.validate,
              isLoading: BlocProvider.of<CreateCompanyProfileCubit>(context)
                  .state is CreatingCompany,
              onTap: () {
                BlocProvider.of<CreateCompanyProfileCubit>(context)
                    .validateCompanyData(context);
              },
              color: AppColors.accent1Shade1,
            ),
          ),
        ],
      ),
    );
  }
}
