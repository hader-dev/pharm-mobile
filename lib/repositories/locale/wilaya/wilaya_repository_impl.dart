import 'package:hader_pharm_mobile/repositories/locale/wilaya/actions/load_wilaya_towns.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/actions/load_wilayas.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/params/load_wilaya_towns_params.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/params/load_wilayas_params.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/responses/load_wilaya_towns_response.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/responses/load_wilayas_response.dart';
import 'wilaya_repository.dart';

class WilayaRepositoryImpl implements IWilayaRepository {
  @override
  Future<ResponseLoadWilayaTowns> getWilayaTowns(ParamsLoadWilayaTowns params) {
    return loadWilayaTowns(params);
  }

  @override
  Future<ResponseLoadWilayas> getWilayas(ParamsLoadWilayas params) {
    return loadFilters(params);
  }
}
