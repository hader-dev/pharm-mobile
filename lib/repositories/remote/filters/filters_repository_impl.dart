import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/repositories/remote/filters/actions/load_filter_medical.dart';
import 'package:hader_pharm_mobile/repositories/remote/filters/params/param_load_para_medical_fitlers.dart';
import 'package:hader_pharm_mobile/repositories/remote/filters/params/params_load_medical_filters.dart';
import 'package:hader_pharm_mobile/repositories/remote/filters/responses/response_load_filter.dart';

import 'filters_repository.dart';

class FiltersRepositoryImpl implements IFiltersRepository {
  final INetworkService client;

  FiltersRepositoryImpl({required this.client});

  @override
  Future<ResponseLoadFilter> getParaMedicalFilter(ParamLoadParaMedicalFilter params) {
    throw UnimplementedError();
    //return loadFiltersParaMedical(client, params);
  }

  @override
  Future<ResponseLoadFilter> getMedicalFilter(ParamLoadMedicalFilter param) async {
    return loadMedicalFilter(client, param);
  }
}
