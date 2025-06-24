import 'package:dio/dio.dart';

import 'package:hader_pharm_mobile/features/common_features/create_company_profile/hooks_data_model/create_company_profile_form.dart';

import '../../../config/services/network/network_interface.dart';

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
}
