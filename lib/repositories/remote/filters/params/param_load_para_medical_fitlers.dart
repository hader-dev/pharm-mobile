import 'package:hader_pharm_mobile/models/para_medical_filters.dart';

class ParamLoadParaMedicalFilter {
  final ParaMedicalFiltersKeys key;
  final String query;
  final int limit;
  final String sort;
  final int offset;
  ParamLoadParaMedicalFilter(
      {required this.key,
      this.query = '',
      this.limit = 10,
      this.offset = 0,
      this.sort = 'ASC'});
}
