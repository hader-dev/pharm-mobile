import '../../../models/para_pharma.dart';
import '../../../models/para_pharma_response.dart';
import '../../../utils/enums.dart';

abstract class IParaPharmaRepository {
  Future<ParaPharmaResponse> getParaPharmaCatalog(
      {int limit = 8,
      int offset = 0,
      String sortDirection = 'ASC',
      List<String> fields = const [],
      SearchParaPharmaFilters? searchFilter,
      String? companyIdFilter,
      String search = ''});
  Future<ParaPharmaCatalogModel> getParaPharmaCatalogById(String id);
}
