import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/edit_company/cubit/edit_company_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/edit_company/view_company/widgets/company_info_display.dart';
import 'package:hader_pharm_mobile/features/common_features/edit_company/view_company/widgets/company_logo_display.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/company_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart' show Iconsax;

class ViewCompanyScreen extends StatelessWidget {
  const ViewCompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditCompanyCubit(
          companyRepository: CompanyRepository(
        client: getItInstance.get<INetworkService>(),
        userManager: getItInstance.get<UserManager>(),
      ))
        ..initCompanyData(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.bgWhite,
          appBar: CustomAppBarV2.alternate(
            leading: IconButton(
              icon: Icon(
                Directionality.of(context) == TextDirection.rtl
                    ? Iconsax.arrow_right_3
                    : Iconsax.arrow_left_2,
                color: AppColors.bgWhite,
                size: AppSizesManager.iconSize25,
              ),
              onPressed: () {
                context.pop();
              },
            ),
            title: Text(
              context.translation!.company_information,
              style: context.responsiveTextTheme.current.headLine3SemiBold
                  .copyWith(color: AppColors.bgWhite),
            ),
          ),
          body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
            child: BlocBuilder<EditCompanyCubit, EditCompanyState>(
              builder: (context, state) {
                if (state is EditCompanyLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const ResponsiveGap.s16(),
                    Text(context.translation!.view_company_description,
                        style: context.responsiveTextTheme.current.body1Medium
                            .copyWith(
                          color: TextColors.ternary.color,
                        )),
                    const ResponsiveGap.s24(),
                    const CompanyLogoDisplay(),
                    const ResponsiveGap.s24(),
                    const CompanyInfoDisplay(),
                    const ResponsiveGap.s16(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
