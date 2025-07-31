import 'package:hader_pharm_mobile/repositories/locale/wilaya/wilaya_repository.dart';

class ParamsLoadWilayas {
  final String locale;
  final JsonStringLoader? jsonStringLoader;
  final String rootPath;

  ParamsLoadWilayas(
      {this.locale = "en",
      this.rootPath = "assets/json/wilaya",
      this.jsonStringLoader});
}
