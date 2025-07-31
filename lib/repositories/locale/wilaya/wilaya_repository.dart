import 'package:hader_pharm_mobile/repositories/locale/wilaya/params/load_wilaya_towns_params.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/params/load_wilayas_params.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/responses/load_wilaya_towns_response.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/responses/load_wilayas_response.dart';


typedef JsonStringLoader = Future<String> Function(String path);

abstract class IWilayaRepository {
  Future<ResponseLoadWilayas> getWilayas(ParamsLoadWilayas params);
  Future<ResponseLoadWilayaTowns> getWilayaTowns(ParamsLoadWilayaTowns params);

}