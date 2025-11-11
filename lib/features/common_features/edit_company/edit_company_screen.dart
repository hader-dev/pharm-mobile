import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/edit_company/cubit/edit_company_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/edit_company/widgets/company_form_section.dart';
import 'package:hader_pharm_mobile/features/common_features/edit_company/widgets/company_logo_section.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/company_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart' show Iconsax;

enum CompanyScreenMode { view, edit }

class CompanyEditScreen extends StatelessWidget {
  final CompanyScreenMode? initialMode;

  const CompanyEditScreen({
    super.key,
    this.initialMode = CompanyScreenMode.view,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditCompanyCubit(
          companyRepository: CompanyRepository(
        client: getItInstance.get<INetworkService>(),
        userManager: getItInstance.get<UserManager>(),
      ))
        ..initCompanyData(),
      child: Scaffold(
        backgroundColor: AppColors.bgWhite,
        appBar: CustomAppBarV2.alternate(
          leading: IconButton(
            icon: Icon(
              Directionality.of(context) == TextDirection.rtl
                  ? Iconsax.arrow_right_3
                  : Iconsax.arrow_left_2,
              color: AppColors.bgWhite,
              size: context.responsiveAppSizeTheme.current.iconSize25,
            ),
            onPressed: () {
              context.pop();
            },
          ),
          title: Text(
            initialMode == CompanyScreenMode.edit
                ? context.translation!.edit_company
                : context.translation!.view_company,
            style: context.responsiveTextTheme.current.headLine3SemiBold
                .copyWith(color: AppColors.bgWhite),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: context.responsiveAppSizeTheme.current.p16),
            child: BlocBuilder<EditCompanyCubit, EditCompanyState>(
              builder: (context, state) {
                
                if (state is EditCompanyLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is EditCompanyNoCompanyFound) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.business_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const ResponsiveGap.s16(),
                        Text(
                          context.translation!.no_company_found,
                          style: context
                              .responsiveTextTheme.current.headLine3SemiBold,
                        ),
                        const ResponsiveGap.s8(),
                        Text(
                          context.translation!.create_company_profile_required,
                          style: context.responsiveTextTheme.current.body1Medium
                              .copyWith(color: TextColors.ternary.color),
                          textAlign: TextAlign.center,
                        ),
                        ResponsiveGap.s24(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                context.pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[300],
                                foregroundColor: Colors.black,
                              ),
                              child: Text(context.translation!.go_back),
                            ),
                            SizedBox(
                                width:
                                    context.responsiveAppSizeTheme.current.s16),
                            ElevatedButton(
                              onPressed: () {
                                context.pop();
                                context.pushNamed(
                                    RoutingManager.createCompanyProfile);
                              },
                              child: Text(
                                context.translation!.create_company,
                                style: context
                                    .responsiveTextTheme.current.body1Medium
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }

                return ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const ResponsiveGap.s16(),
                    Text(
                      initialMode == CompanyScreenMode.edit
                          ? context.translation!.update_company_description
                          : context.translation!.view_company_description,
                      style: context.responsiveTextTheme.current.body1Medium
                          .copyWith(
                        color: TextColors.ternary.color,
                      ),
                    ),
                    const ResponsiveGap.s24(),
                    const CompanyLogoSection(),
                    const ResponsiveGap.s24(),
                    CompanyFormSection(
                      isEditable: initialMode == CompanyScreenMode.edit,
                    ),
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
