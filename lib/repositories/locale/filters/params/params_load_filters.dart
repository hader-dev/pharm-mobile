import 'package:hader_pharm_mobile/models/medical_filters.dart';
import 'package:hader_pharm_mobile/models/para_medical_filters.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/wilaya_repository.dart';

class ParamsLoadFiltersMedical {
  final String locale;
  final JsonStringLoader? jsonStringLoader;
  final String rootPath;
  final List<MedicalFiltersKeys> filterItems;

  ParamsLoadFiltersMedical(
      {this.locale = "en",
      this.rootPath = "assets/json/filters",
      this.jsonStringLoader,
      this.filterItems = MedicalFiltersKeys.values,
      });
}

class ParamsLoadFiltersParaMedical {
  final String locale;
  final JsonStringLoader? jsonStringLoader;
  final String rootPath;
  final List<ParaMedicalFiltersKeys> filterItems;

  ParamsLoadFiltersParaMedical(
      {this.locale = "en",
      this.rootPath = "assets/json/filters", 
      this.jsonStringLoader,
      this.filterItems = ParaMedicalFiltersKeys.values,
      });
}
