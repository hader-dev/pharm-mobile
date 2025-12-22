import 'package:hader_pharm_mobile/models/para_pharm_filters.dart';

class ParamsLoadParapharma {
  final int page;
  final int limit;
  final String sortDirection;
  final List<String> fields;
  final ParaPharmFilters filters;
  final int offset;
  final String? companyId;
  final String? buyerCompanyId;
  final bool includeFavorites;
  final String? searchQuery;

  ParamsLoadParapharma(
      {this.limit = 8,
      this.page = 1,
      this.buyerCompanyId,
      this.companyId,
      this.searchQuery,
      this.offset = 0,
      this.sortDirection = 'DESC',
      this.fields = const [],
      this.filters = const ParaPharmFilters(),
      this.includeFavorites = true});
}
