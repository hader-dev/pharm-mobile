import 'package:hader_pharm_mobile/repositories/locale/wilaya/wilaya_repository.dart';

class ParamsLoadWilayaTowns {
  final int wilayaId;
  final String locale;
  final JsonStringLoader? jsonStringLoader;
  final String rootPath;

  const ParamsLoadWilayaTowns(
      {this.locale = "en",
      this.rootPath = "assets/json/town",
      required this.wilayaId,
      this.jsonStringLoader});
}
