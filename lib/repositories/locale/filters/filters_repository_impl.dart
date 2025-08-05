import 'package:hader_pharm_mobile/repositories/locale/filters/actions/load_filters_medical.dart';
import 'package:hader_pharm_mobile/repositories/locale/filters/actions/load_filters_para_medical.dart';
import 'package:hader_pharm_mobile/repositories/locale/filters/params/params_load_filters.dart';
import 'package:hader_pharm_mobile/repositories/locale/filters/responses/response_load_filters_medical.dart';
import 'package:hader_pharm_mobile/repositories/locale/filters/responses/response_load_filters_para_medical.dart';
import 'filters_repository.dart';

class FiltersRepositoryImpl implements IFiltersRepository {

  @override
  Future<ResponseLoadFiltersMedical> getMedicalFilters(ParamsLoadFiltersMedical params) {
    return loadFiltersMedical(params);
  }

  @override
  Future<ResponseLoadFiltersParaMedical> getParaMedicalFilters(ParamsLoadFiltersParaMedical params) {
    return loadFiltersParaMedical(params);
  }
}