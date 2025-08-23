import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/hooks_data_model/create_company_profile_form.dart';
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/mappers/json_to_company.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/mime_type.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';
import 'package:http_parser/http_parser.dart';

import 'company_repository.dart';

class CompanyRepository extends ICompanyRepository {
  final INetworkService client;
  CompanyRepository({required this.client});
  @override
  Future<void> createCompany(
      CreateCompanyProfileFormDataModel companyData) async {
    Map<String, dynamic> dataAsMap = companyData.toJson();
    dataAsMap.removeWhere(
        (key, value) => value == null || (value is String && value.isEmpty));

    late MultipartFile file;
    final String? userImagePath = companyData.logoPath;

    if (userImagePath != null) {
      String fileName = userImagePath.split('/').last;

      String fileExtension = fileName.split('.').last.toLowerCase();
      String mimeType = getMimeTypeFromExtension(fileExtension);

      debugPrint("SignUp - Image file: $mimeType");
      file = await MultipartFile.fromFile(
        userImagePath,
        filename: fileName,
        contentType: MediaType.parse(mimeType),
      );
    }

    FormData formData = FormData.fromMap({
      ...dataAsMap,
      if (companyData.logoPath != null) 'image': file,
    });

    await client
        .sendRequest(() => client.post(Urls.company, payload: formData));
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
      if (distributorCategoryId != null)
        'filters[distributorCategory]': distributorCategoryId.toString(),
      if (searchFilter != null) 'search[${searchFilter.name}]': search,
      if (fields != null) ...{'fields[]': fields},
      'filters[type]': companyType.id.toString(),
    };

    var decodedResponse = await client
        .sendRequest(() => client.get(Urls.company, queryParams: queryParams));
    return (decodedResponse["data"] as List)
        .map((json) => jsonToCompany(json))
        .toList();
  }

  @override
  Future<void> joinCompanyAsCLient({required String companyId}) {
    return client.sendRequest(() => client.post(Urls.clientsCompaniesJoin,
        payload: {'sellerCompanyId': companyId}));
  }

  @override
  Future<void> addCompanyToFavorites({required String companyId}) {
    return client.sendRequest(() => client.post(Urls.favoritesCompany,
        payload: {'favoriteCompanyId': companyId}));
  }

  @override
  Future<List<Brand>> getCompanyBrands({required String companyId}) async {
    var decodedResponse = await client.sendRequest(() => client.get(
          Urls.parapharmBrands,
        ));

    return (decodedResponse["data"] as List)
        .map((brandItem) => Brand.fromJson(brandItem))
        .toList();
  }

  @override
  Future<List<Brand>> getCompanyCategories({required String companyId}) {
    // TODO: implement getCompanyCategories
    throw UnimplementedError();
  }

  @override
  Future<Company> getCompanyById({required String companyId}) async {
    var decodedResponse = await client
        .sendRequest(() => client.get('${Urls.company}/$companyId'));

    return jsonToCompany(decodedResponse);
  }

  @override
  Future<void> removeCompanyFromFavorites({required String companyId}) {
    // TODO: implement removeCompanyFromFavorites
    throw UnimplementedError();
  }

  @override
  Future<void> unJoinCompanyAsCLient({required String companyId}) {
    // TODO: implement unJoinCompanyAsCLient
    throw UnimplementedError();
  }
}
