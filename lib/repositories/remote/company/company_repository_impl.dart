import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/hooks_data_model/create_company_profile_form.dart';
import 'package:hader_pharm_mobile/features/common_features/edit_company/hooks_data_model/edit_company_form.dart';
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
  final UserManager userManager;

  CompanyRepository({required this.client, required this.userManager});
  @override
  Future<void> createCompany(CreateCompanyProfileFormDataModel companyData) async {
    Map<String, dynamic> dataAsMap = companyData.toJson();
    dataAsMap.removeWhere((key, value) => value == null || (value is String && value.isEmpty));

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

    await client.sendRequest(() => client.post(Urls.company, payload: formData));
  }

  @override
  Future<List<Company>> getCompanies(
      {int limit = PaginationConstants.resultsPerPage,
      int offset = 0,
      String sortDirection = 'DESC',
      String search = '',
      SearchVendorFilters? searchFilter,
      int? distributorCategoryId,
      List<String>? fields,
      bool computeFavorite = false,
      required CompanyType companyType}) async {
    final queryParams = {
      'limit': limit.toString(),
      'offset': offset.toString(),
      'sort[id]': sortDirection,
      if (distributorCategoryId != null) 'filters[distributorCategory]': distributorCategoryId.toString(),
      if (searchFilter != null && search.isNotEmpty) 'search[${searchFilter.name}]': search,
      if (fields != null) ...{'fields[]': fields},
      if (computeFavorite) ...{'computed[isFavorite]': true.toString()},
      'filters[type]': companyType.id.toString(),
    };

    var decodedResponse = await client.sendRequest(() => client.get(Urls.company, queryParams: queryParams));
    return (decodedResponse["data"] as List).map((json) => jsonToCompany(json)).toList();
  }

  @override
  Future<void> joinCompanyAsCLient({required String companyId}) {
    return client.sendRequest(() => client.post(Urls.clientsCompaniesJoin, payload: {'sellerCompanyId': companyId}));
  }

  @override
  Future<void> likeVendor({required String companyId}) {
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
  Future<List<Brand>> getCompanyCategories({required String companyId}) async {
    throw UnimplementedError();
  }

  @override
  Future<Company> getCompanyById({required String companyId}) async {
    var decodedResponse = await client.sendRequest(() => client.get('${Urls.company}/$companyId'));

    return jsonToCompany(decodedResponse);
  }

  @override
  Future<void> unlikeVendor({required String companyId}) async {
    return await client.sendRequest(() => client.delete(
          '${Urls.favoritesCompany}/by-company-id/$companyId',
        ));
  }

  @override
  Future<void> unJoinCompanyAsCLient({required String companyId}) {
    // TODO: implement unJoinCompanyAsCLient
    throw UnimplementedError();
  }

  @override
  Future<Company> getMyCompany() async {
    var decodedResponse = await client.sendRequest(() => client.get(Urls.me));

    if (decodedResponse["company"] != null) {
      return jsonToCompany(decodedResponse["company"]);
    } else {
      throw Exception("No company associated with this user");
    }
  }

  @override
  Future<void> updateMyCompany({required EditCompanyFormDataModel companyData, bool shouldRemoveImage = false}) async {
    try {
      if (companyData.logoPath != null && !shouldRemoveImage) {
        await _updateCompanyWithImage(companyData);
      } else {
        await _updateCompanyWithoutImage(companyData, shouldRemoveImage);
      }
    } catch (e) {
      debugPrint("Company update error: $e");
      rethrow;
    }
  }

  Future<void> _updateCompanyWithImage(EditCompanyFormDataModel companyData) async {
    try {
      String? companyId = await userManager.getCompanyId();

      if (companyId?.isEmpty ?? true) {
        throw Exception("Company ID not found");
      }

      Map<String, dynamic> dataAsMap = companyData.toJson();

      late MultipartFile file;
      final String? logoPath = companyData.logoPath;

      if (logoPath != null) {
        String fileName = logoPath.split('/').last;
        String fileExtension = fileName.split('.').last.toLowerCase();
        String mimeType = getMimeTypeFromExtension(fileExtension);

        file = await MultipartFile.fromFile(
          logoPath,
          filename: fileName,
          contentType: MediaType.parse(mimeType),
        );
      }

      FormData formData = FormData.fromMap({
        ...dataAsMap,
        if (logoPath != null) 'image': file,
      });

      await client.sendRequest(() => client.patch(
            '${Urls.company}/$companyId',
            payload: formData,
            headers: {'Content-Type': 'multipart/form-data'},
          ));
    } catch (e) {
      debugPrint("Company update - Failed with image, trying without: $e");

      await _updateCompanyWithoutImage(companyData, false);
    }
  }

  Future<void> _updateCompanyWithoutImage(EditCompanyFormDataModel companyData, bool shouldRemoveImage) async {
    try {
      String? companyId = await userManager.getCompanyId();
      if (companyId?.isEmpty ?? true) {
        throw Exception("Company ID not found");
      }

      Map<String, dynamic> payload = companyData.toJson();

      // If we should remove the image, add a flag or remove image field
      if (shouldRemoveImage) {
        payload['removeImage'] = true;
      }

      var response = await client.sendRequest(() => client.patch(
            '${Urls.company}/$companyId',
            payload: payload,
            headers: {'Content-Type': 'application/json'},
          ));

      debugPrint("Company update - SUCCESS: $response");
    } catch (e) {
      debugPrint("Company update - Error occurred: $e");
      rethrow;
    }
  }
}
