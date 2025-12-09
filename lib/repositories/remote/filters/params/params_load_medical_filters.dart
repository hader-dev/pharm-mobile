import 'package:hader_pharm_mobile/models/medical_filters.dart';
import 'package:hader_pharm_mobile/models/para_medical_filters.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/wilaya_repository.dart';

class ParamLoadMedicalFilter {
  final MedicalFiltersKeys key;
  final String query;
  final int limit;
  final String sort;
  final int offset;
  ParamLoadMedicalFilter({required this.key, this.query = '', this.limit = 10, this.offset = 0, this.sort = 'ASC'});
}

class FilterParam {
  final MedicalFiltersKeys key;
  final String query;
  const FilterParam({required this.key, this.query = ''});

  FilterParam copyWith({
    String? query,
  }) =>
      FilterParam(key: key, query: query ?? this.query);
}

class ParamsLoadFiltersMedical {
  final String locale;
  final JsonStringLoader? jsonStringLoader;
  final String rootPath;
  final List<FilterParam> filterItems;

  ParamsLoadFiltersMedical({
    this.locale = "en",
    this.rootPath = "assets/json/filters",
    this.jsonStringLoader,
    this.filterItems = const [
      FilterParam(key: MedicalFiltersKeys.dci),
      FilterParam(key: MedicalFiltersKeys.dosage),
      FilterParam(key: MedicalFiltersKeys.form),
      FilterParam(key: MedicalFiltersKeys.status),
      FilterParam(key: MedicalFiltersKeys.laboratoryCountry),
      FilterParam(key: MedicalFiltersKeys.laboratoryHolder),
      FilterParam(key: MedicalFiltersKeys.brandName),
      // FilterParam(key: MedicalFiltersKeys.condition),
      FilterParam(key: MedicalFiltersKeys.type),
      // FilterParam(key: MedicalFiltersKeys.stabilityDuration),
      FilterParam(key: MedicalFiltersKeys.distributorSku),
      FilterParam(key: MedicalFiltersKeys.code),
      FilterParam(key: MedicalFiltersKeys.p1),
    ],
  });

  void updateFilterParams(MedicalFiltersKeys key, String query) {}

  ParamsLoadFiltersMedical copyWith({
    String? locale,
    JsonStringLoader? jsonStringLoader,
    String? rootPath,
    List<FilterParam>? filterItems,
  }) {
    return ParamsLoadFiltersMedical(
      locale: locale ?? this.locale,
      jsonStringLoader: jsonStringLoader ?? this.jsonStringLoader,
      rootPath: rootPath ?? this.rootPath,
      filterItems: filterItems ?? this.filterItems,
    );
  }
}

class ParamsLoadFiltersParaMedical {
  final String locale;
  final JsonStringLoader? jsonStringLoader;
  final String rootPath;
  //final List<ParaMedicalFiltersKeys> filterItems;

  ParamsLoadFiltersParaMedical({
    this.locale = "en",
    this.rootPath = "assets/json/filters",
    this.jsonStringLoader,
    // this.filterItems = const [
    // ParaMedicalFiltersKeys.sku,
    // ParaMedicalFiltersKeys.name,
    // ParaMedicalFiltersKeys.description,
    // ParaMedicalFiltersKeys.dosage,
    // ParaMedicalFiltersKeys.status,
    // ParaMedicalFiltersKeys.country,
    // ParaMedicalFiltersKeys.patent,
    // ParaMedicalFiltersKeys.brand,
    // ParaMedicalFiltersKeys.condition,
    // ParaMedicalFiltersKeys.type,
    // ParaMedicalFiltersKeys.stabilityDuration,
    // ParaMedicalFiltersKeys.code,
    // ParaMedicalFiltersKeys.reimbursement,
    // ParaMedicalFiltersKeys.sku,
    // ],
  });
}
