import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/sub_pages/review&submit/review&submit.dart';
import 'package:hader_pharm_mobile/features/pharmacy/create_pharmacy/sub_pages/compay_profile/compay_profile.dart';
import 'package:hader_pharm_mobile/features/pharmacy/create_pharmacy/sub_pages/general_information/general_information.dart';
import 'package:hader_pharm_mobile/features/pharmacy/create_pharmacy/sub_pages/legal_information/legal_information.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/company_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';

import '../../../config/di/di.dart';
import '../../../config/routes/routing_manager.dart';
import '../../../utils/constants.dart';
import '../../../utils/toast_helper.dart';
import '../../common/widgets/welcoming_widget.dart';
import '../../distributor/create_distributor/sub_pages/compay_profile/compay_profile.dart';
import '../../distributor/create_distributor/sub_pages/general_information/general_information.dart';
import '../../distributor/create_distributor/sub_pages/legal_information/legal_information.dart';
import 'cubit/create_company_profile_cubit.dart';
import 'sub_pages/company_type/company_type.dart';

import 'widgets/navigation_buttons_section.dart';
import 'widgets/page_header_section.dart';

class CreateCompanyProfile extends StatelessWidget {
  const CreateCompanyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => CreateCompanyProfileCubit(
            companyRepository: CompanyRepository(client: getItInstance.get<INetworkService>())),
        child: Scaffold(
          body: BlocListener<CreateCompanyProfileCubit, CreateCompanyProfileState>(
            listener: (context, state) {
              if (state is CompanyCreated) {
                getItInstance
                    .get<ToastManager>()
                    .showToast(type: ToastType.success, message: "Company created successfully");
                context.pushReplacementNamed(RoutingManager.appLayout);
              }
            },
            child: BlocBuilder<CreateCompanyProfileCubit, CreateCompanyProfileState>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Gap(AppSizesManager.s24),
                    PageHeaderSection(
                      currentStep: BlocProvider.of<CreateCompanyProfileCubit>(context).currentStepIndex,
                    ),
                    Gap(AppSizesManager.s16),
                    Expanded(
                        child: PageView(
                      controller: BlocProvider.of<CreateCompanyProfileCubit>(context).pageController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        CompanyTypePage(),
                        if (BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.companyType ==
                            CompanyType.pharmacy.id) ...[
                          PharmacyGeneralInformationPage(),
                          PharmacyLegalInformationPage(),
                          PharmacyProfilePage()
                        ],
                        if (BlocProvider.of<CreateCompanyProfileCubit>(context).companyData.companyType ==
                            CompanyType.distributor.id) ...[
                          DistributorGeneralInformationPage(),
                          DistributorLegalInformationPage(),
                          DistributorProfilePage()
                        ],
                        ReviewSubmitPage(),
                      ],
                    )),
                    NavigationButtonsSection(),
                    Gap(AppSizesManager.s12),
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
