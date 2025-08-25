import 'package:hader_pharm_mobile/repositories/remote/filters/params/param_load_para_medical_fitlers.dart';
import 'package:hader_pharm_mobile/repositories/remote/filters/params/params_load_medical_filters.dart';
import 'package:hader_pharm_mobile/repositories/remote/filters/responses/response_load_filter.dart';

typedef JsonStringLoader = Future<String> Function(String path);

abstract class IFiltersRepository {
  Future<ResponseLoadFilter> getMedicalFilter(ParamLoadMedicalFilter param);

  Future<ResponseLoadFilter> getParaMedicalFilter(
      ParamLoadParaMedicalFilter params);
}
