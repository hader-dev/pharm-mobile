import 'package:equatable/equatable.dart';
import 'package:hader_pharm_mobile/utils/enums.dart' show ParaPharmSearchByFields;

// enum ParaMedicalFiltersKeys {
//   sku,
//   name,
//   description,
//   dosage,
//   status,
//   country,
//   patent,
//   vendors,
//   brand,
//   condition,
//   type,
//   stabilityDuration,
//   code,
//   reimbursement,
//   unitPriceHt;
// }

class ParaMedicalFilters extends Equatable {
  final ParaPharmSearchByFields searchByField;
  final double minPriceFilter;
  final double maxPriceFilter;

  const ParaMedicalFilters({
    this.searchByField = ParaPharmSearchByFields.name,
    this.minPriceFilter = 0.0,
    this.maxPriceFilter = 0.0,
  });

  @override
  List<Object?> get props => [];
}
