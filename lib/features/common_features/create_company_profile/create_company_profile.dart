import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/sub_pages/review_and_sumbit/review_and_sumbit.dart';
import 'package:hader_pharm_mobile/features/common_features/wilaya/cubit/wilaya_cubit.dart';
import 'package:hader_pharm_mobile/features/distributor/create_distributor/sub_pages/compay_profile/compay_profile.dart';
import 'package:hader_pharm_mobile/features/distributor/create_distributor/sub_pages/general_information/general_information.dart';
import 'package:hader_pharm_mobile/features/distributor/create_distributor/sub_pages/legal_information/legal_information.dart';
import 'package:hader_pharm_mobile/features/pharmacy/create_pharmacy/sub_pages/compay_profile/compay_profile.dart';
import 'package:hader_pharm_mobile/features/pharmacy/create_pharmacy/sub_pages/general_information/general_information.dart';
import 'package:hader_pharm_mobile/features/pharmacy/create_pharmacy/sub_pages/legal_information/legal_information.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/wilaya_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/company_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';

import 'cubit/create_company_profile_cubit.dart';
import 'sub_pages/company_type/company_type.dart';
import 'widgets/navigation_buttons_section.dart';
import 'widgets/page_header_section.dart';

class CreateCompanyProfile extends StatelessWidget {
  const CreateCompanyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateCompanyProfileCubit(
              companyRepository: CompanyRepository(
            client: getItInstance.get<INetworkService>(),
            userManager: getItInstance.get<UserManager>(),
          )),
        ),
        BlocProvider(
          create: (context) =>
              WilayaCubit(wilayaRepository: WilayaRepositoryImpl()),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<CreateCompanyProfileCubit,
              CreateCompanyProfileState>(
            listener: (context, state) {
              if (state is CompanyCreated) {
                getItInstance.get<ToastManager>().showToast(
                    type: ToastType.success,
                    message: context.translation!.feedback_company_created);
                context.pushReplacementNamed(RoutingManager.appLayout);
              }
            },
            child: BlocBuilder<CreateCompanyProfileCubit,
                CreateCompanyProfileState>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ResponsiveGap.s24(),
                    PageHeaderSection(
                      currentStep:
                          BlocProvider.of<CreateCompanyProfileCubit>(context)
                              .currentStepIndex,
                    ),
                    const ResponsiveGap.s16(),
                    Expanded(
                        child: PageView(
                      controller:
                          BlocProvider.of<CreateCompanyProfileCubit>(context)
                              .pageController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        CompanyTypePage(),
                        if (isCommercialOrPharmaType(context)) ...[
                          PharmacyGeneralInformationPage(),
                          PharmacyLegalInformationPage(),
                          PharmacyProfilePage()
                        ],
                        if (BlocProvider.of<CreateCompanyProfileCubit>(context)
                                .companyData
                                .companyType ==
                            CompanyType.Distributor.id) ...[
                          DistributorGeneralInformationPage(),
                          DistributorLegalInformationPage(),
                          DistributorProfilePage()
                        ],
                        ReviewSubmitPage(),
                      ],
                    )),
                    NavigationButtonsSection(),
                    const ResponsiveGap.s12(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  bool isCommercialOrPharmaType(BuildContext context) {
    return (BlocProvider.of<CreateCompanyProfileCubit>(context)
                .companyData
                .companyType ==
            CompanyType.Pharmacy.id) ||
        (BlocProvider.of<CreateCompanyProfileCubit>(context)
                .companyData
                .companyType ==
            CompanyType.Other.id);
  }
}
