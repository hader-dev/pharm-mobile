import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/params/params_load_parapharma.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/response/para_pharma_response.dart';

abstract class IParaPharmaRepository {
  Future<ParaPharmaResponse> getParaPharmaCatalog(ParamsLoadParapharma params);
  Future<ParaPharmaCatalogModel> getParaPharmaCatalogById(String id);
}
