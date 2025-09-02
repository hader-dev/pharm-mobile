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
import 'package:hader_pharm_mobile/features/common/widgets/empty_list.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/company_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart' show Iconsax;

import 'cubit/edit_company_cubit.dart';
import 'view_company/widgets/company_info_display.dart';
import 'view_company/widgets/company_logo_display.dart';
import 'widgets/company_form_section.dart';
import 'widgets/company_logo_section.dart';

enum CompanyScreenMode { view, edit }

class EditCompanyScreen extends StatefulWidget {
  final CompanyScreenMode? initialMode;

  const EditCompanyScreen({
    super.key,
    this.initialMode = CompanyScreenMode.view,
  });

  @override
  State<EditCompanyScreen> createState() => _EditCompanyScreenState();
}

class _EditCompanyScreenState extends State<EditCompanyScreen> {
  late CompanyScreenMode currentMode;

  @override
  void initState() {
    super.initState();
    currentMode = widget.initialMode ?? CompanyScreenMode.view;
  }

  void toggleMode() {
    setState(() {
      currentMode = currentMode == CompanyScreenMode.view
          ? CompanyScreenMode.edit
          : CompanyScreenMode.view;
    });
  }

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
              currentMode == CompanyScreenMode.edit
                  ? context.translation!.edit_company
                  : context.translation!.view_company,
              style: context.responsiveTextTheme.current.headLine3SemiBold
                  .copyWith(color: AppColors.bgWhite),
            ),
            trailing: [
              BlocBuilder<EditCompanyCubit, EditCompanyState>(
                builder: (context, state) {
                  if (state is EditCompanySuccess ||
                      state is CompanyDataLoaded) {
                    return IconButton(
                      icon: Icon(
                        currentMode == CompanyScreenMode.view
                            ? Iconsax.edit
                            : Iconsax.eye,
                        color: AppColors.bgWhite,
                        size: AppSizesManager.iconSize25,
                      ),
                      onPressed: toggleMode,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
          body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
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
                        SizedBox(height: 16),
                        Text(
                          context.translation!.no_company_found,
                          style: context
                              .responsiveTextTheme.current.headLine3SemiBold,
                        ),
                        SizedBox(height: 8),
                        Text(
                          context.translation!.create_company_profile_required,
                          style: context.responsiveTextTheme.current.body1Medium
                              .copyWith(color: TextColors.ternary.color),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 24),
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
                            SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () {
                                context.pop(); // Go back first
                                context.pushNamed(
                                    RoutingManager.createCompanyProfile);
                              },
                              child: Text(context.translation!.create_company),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }

                if (state is EditCompanyFailed) {
                  return Center(
                    child: EmptyListWidget(
                      onRefresh: () {
                        context.read<EditCompanyCubit>().initCompanyData();
                      },
                    ),
                  );
                }

                return ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const ResponsiveGap.s16(),
                    _buildDescriptionText(context),
                    const ResponsiveGap.s24(),
                    _buildCompanyContent(),
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

  Widget _buildDescriptionText(BuildContext context) {
    return Text(
      currentMode == CompanyScreenMode.edit
          ? context.translation!.update_company_description
          : context.translation!.view_company_description,
      style: context.responsiveTextTheme.current.body1Medium.copyWith(
        color: TextColors.ternary.color,
      ),
    );
  }

  Widget _buildCompanyContent() {
    if (currentMode == CompanyScreenMode.edit) {
      return Column(
        children: [
          const CompanyLogoSection(),
          const ResponsiveGap.s24(),
          const CompanyFormSection(),
        ],
      );
    } else {
      return Column(
        children: [
          const CompanyLogoDisplay(),
          const ResponsiveGap.s24(),
          const CompanyInfoDisplay(),
        ],
      );
    }
  }
}
