import 'package:hader_pharm_mobile/features/common_features/create_company_profile/hooks_data_model/create_company_profile_form.dart';
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';

import '../../../utils/constants.dart';

abstract class ICompanyRepository {
  Future<void> createCompany(CreateCompanyProfileFormDataModel companyData);
  Future<List<Company>> getCompanies(
      {int limit = PaginationConstants.resultsPerPage,
      int offset = 0,
      String sortDirection = 'ASC',
      String search = '',
      SearchVendorFilters? searchFilter,
      required CompanyType companyType,
      int? distributorCategoryId});
  Future<void> joinCompanyAsCLient({required String companyId});
  Future<void> addCompanyToFavorites({required String companyId});
}
