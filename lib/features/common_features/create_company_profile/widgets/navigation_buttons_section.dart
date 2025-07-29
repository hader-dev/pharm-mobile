import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/actions/previous_step_or_logout.dart';

import '../../../../utils/constants.dart';
import '../../../common/buttons/solid/primary_text_button.dart';
import '../cubit/create_company_profile_cubit.dart';

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
                  ? "Previous"
                  : "Cancel",
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
                  ? "Next"
                  : "Validate",
              isLoading: BlocProvider.of<CreateCompanyProfileCubit>(context)
                  .state is CreatingCompany,
              onTap: () {
                BlocProvider.of<CreateCompanyProfileCubit>(context)
                    .validateCompanyData();
              },
              color: AppColors.accent1Shade1,
            ),
          ),
        ],
      ),
    );
  }
}
