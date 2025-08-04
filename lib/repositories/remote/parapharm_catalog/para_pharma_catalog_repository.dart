import 'package:hader_pharm_mobile/models/para_medical_filters.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/models/para_pharma_response.dart';


abstract class IParaPharmaRepository {
  Future<ParaPharmaResponse> getParaPharmaCatalog(
      {int limit = 8,
      int offset = 0,
      String sortDirection = 'ASC',
      List<String> fields = const [],
      ParaMedicalFilters filters = const ParaMedicalFilters()});
  Future<ParaPharmaCatalogModel> getParaPharmaCatalogById(String id);
}
