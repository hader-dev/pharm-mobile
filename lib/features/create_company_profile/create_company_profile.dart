import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/constants.dart';
import 'sub_pages/company_type/company_type.dart';
import 'sub_pages/general_information/general_information.dart';
import 'sub_pages/legal_information/legal_information.dart';
import 'sub_pages/compay_profile/compay_profile.dart';
import 'sub_pages/review&submit/review&submit.dart';
import 'widgets/navigation_buttons_section.dart';
import 'widgets/page_header_section.dart';

class CreateCompanyProfile extends StatelessWidget {
  const CreateCompanyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(AppSizesManager.s24),
            PageHeaderSection(
              currentStep: 4,
            ),
            Gap(AppSizesManager.s16),
            Expanded(
                child: PageView(
              children: [
                CompanyTypePage(),
                GeneralInformationPage(),
                LegalInformationPage(),
                CompanyProfilePage(),
                ReviewSubmitPage(),
              ],
            )),
            NavigationButtonsSection(),
            Gap(AppSizesManager.s12),
          ],
        ),
      ),
    );
  }
}
