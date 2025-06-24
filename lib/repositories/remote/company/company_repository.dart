import 'package:hader_pharm_mobile/features/common_features/create_company_profile/hooks_data_model/create_company_profile_form.dart';

abstract class ICompanyRepository {
  Future<void> createCompany(CreateCompanyProfileFormDataModel companyData);
}
