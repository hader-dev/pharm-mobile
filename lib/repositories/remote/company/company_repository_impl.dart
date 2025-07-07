import 'package:dio/dio.dart';

import 'package:hader_pharm_mobile/features/common_features/create_company_profile/hooks_data_model/create_company_profile_form.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';

import '../../../config/services/network/network_interface.dart';

import '../../../models/company.dart';
import '../../../utils/constants.dart';
import '../../../utils/urls.dart';
import 'company_repository.dart';

class CompanyRepository extends ICompanyRepository {
  final INetworkService client;
  CompanyRepository({required this.client});
  @override
  Future<void> createCompany(CreateCompanyProfileFormDataModel companyData) async {
    Map<String, dynamic> dataAsMap = companyData.toJson();
    dataAsMap.removeWhere((key, value) => value == null || (value is String && value.isEmpty));
    FormData formData = FormData.fromMap({
      ...dataAsMap,
      if (companyData.logoPath != null)
        'image': await MultipartFile.fromFile(companyData.logoPath!, filename: companyData.logoPath!.split('/').last),
    });

    await client.sendRequest(() => client.post(Urls.company, payload: formData));
  }

  @override
  Future<List<Company>> getCompanies(
      {int limit = PaginationConstants.resultsPerPage,
      int offset = 0,
      String sortDirection = 'ASC',
      String search = '',
      SearchVendorFilters? searchFilter,
      int? distributorCategoryId,
      required CompanyType companyType}) async {
    final queryParams = {
      'limit': limit,
      'offset': offset,
      'sort[id]': sortDirection,
      if (distributorCategoryId != null) 'filters[distributorCategory]': distributorCategoryId,
      if (searchFilter != null) 'search[${searchFilter.name}]': search,
      'filters[type]': companyType.id,
    };
    var decodedResponse = await client.sendRequest(
        () => client.get(Urls.company, queryParams: queryParams.map((key, value) => MapEntry(key, value.toString()))));
    return (decodedResponse["data"] as List).map((json) => Company.fromJson(json)).toList();
  }

  @override
  Future<void> joinCompanyAsCLient({required String companyId}) {
    return client.sendRequest(() => client.post(Urls.clientsCompaniesJoin, payload: {'sellerCompanyId': companyId}));
  }
}
