import '../../../models/para_pharma.dart';
import '../../../models/para_pharma_response.dart';

abstract class IParaPharmaRepository {
  Future<ParaPharmaResponse> getParaPharmaCatalog({
    int limit = 8,
    int offset = 0,
    String sortDirection = 'ASC',
    List<String> fields = const [],
  });
  Future<ParaPharmaCatalogModel> getParaPharmaCatalogById(String id);
}
