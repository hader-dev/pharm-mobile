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
      this.filterItems = const [
        MedicalFiltersKeys.dci,
        MedicalFiltersKeys.dosage,
        MedicalFiltersKeys.form,
        MedicalFiltersKeys.status,
        MedicalFiltersKeys.country,
        MedicalFiltersKeys.patent,
        MedicalFiltersKeys.brand,
        MedicalFiltersKeys.condition,
        MedicalFiltersKeys.type,
        MedicalFiltersKeys.stabilityDuration,
        MedicalFiltersKeys.code,
        MedicalFiltersKeys.reimbursement,
        MedicalFiltersKeys.distributorSku,
        // unitPriceHt excluded - it's a price filter, not a list-based filter
      ],
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
      this.filterItems = const [
        ParaMedicalFiltersKeys.sku,
        ParaMedicalFiltersKeys.name,
        ParaMedicalFiltersKeys.description,
        ParaMedicalFiltersKeys.dosage,
        ParaMedicalFiltersKeys.status,
        ParaMedicalFiltersKeys.country,
        ParaMedicalFiltersKeys.patent,
        ParaMedicalFiltersKeys.brand,
        ParaMedicalFiltersKeys.condition,
        ParaMedicalFiltersKeys.type,
        ParaMedicalFiltersKeys.stabilityDuration,
        ParaMedicalFiltersKeys.code,
        ParaMedicalFiltersKeys.reimbursement,
        ParaMedicalFiltersKeys.distributorSku,
        // unitPriceHt excluded - it's a price filter, not a list-based filter
      ],
      });
}
