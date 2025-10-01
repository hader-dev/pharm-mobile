import 'package:hader_pharm_mobile/models/para_medical_filters.dart';

class ParamsLoadParapharma {
  final int page;
  final int limit;
  final String sortDirection;
  final List<String> fields;
  final ParaMedicalFilters filters;
  final int offset;
  final String? companyId;
  final bool includeFavorites;

  ParamsLoadParapharma(
      {this.limit = 8,
      this.page = 1,
      this.companyId,
      this.offset = 0,
      this.sortDirection = 'DESC',
      this.fields = const [],
      this.filters = const ParaMedicalFilters(),
      this.includeFavorites = true});
}
