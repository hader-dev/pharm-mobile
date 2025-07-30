import 'package:dio/dio.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/hooks_data_model/create_company_profile_form.dart';
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';
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
      List<String>? fields,
      required CompanyType companyType}) async {
    final queryParams = {
      'limit': limit.toString(),
      'offset': offset.toString(),
      'sort[id]': sortDirection,
      if (distributorCategoryId != null) 'filters[distributorCategory]': distributorCategoryId.toString(),
      if (searchFilter != null) 'search[${searchFilter.name}]': search,
      if (fields != null) ...{'fields[]': fields},
      'filters[type]': companyType.id.toString(),
    };

    var decodedResponse = await client.sendRequest(() => client.get(Urls.company, queryParams: queryParams));
    return (decodedResponse["data"] as List).map((json) => Company.fromJson(json)).toList();
  }

  @override
  Future<void> joinCompanyAsCLient({required String companyId}) {
    return client.sendRequest(() => client.post(Urls.clientsCompaniesJoin, payload: {'sellerCompanyId': companyId}));
  }

  @override
  Future<void> addCompanyToFavorites({required String companyId}) {
    return client.sendRequest(() => client.post(Urls.favoritesCompany, payload: {'favoriteCompanyId': companyId}));
  }

  @override
  Future<List<Brand>> getCompanyBrands({required String companyId}) async {
    var decodedResponse = await client.sendRequest(() => client.get(
          Urls.parapharmBrands,
        ));

    return (decodedResponse["data"] as List).map((brandItem) => Brand.fromJson(brandItem)).toList();
  }

  @override
  Future<List<Brand>> getCompanyCategories({required String companyId}) {
    // TODO: implement getCompanyCategories
    throw UnimplementedError();
  }

  @override
  Future<Company> getCompanyById({required String companyId}) async {
    var decodedResponse = await client.sendRequest(() => client.get('${Urls.company}/$companyId'));

    return Company.fromJson(decodedResponse);
  }
}
