import 'package:hader_pharm_mobile/repositories/locale/filters/params/params_load_filters.dart';
import 'package:hader_pharm_mobile/repositories/locale/filters/responses/response_load_filters_medical.dart';


typedef JsonStringLoader = Future<String> Function(String path);

abstract class IFiltersRepository {
  Future<ResponseLoadFiltersMedical> getMedicalFilters(ParamsLoadFiltersMedical params);

}