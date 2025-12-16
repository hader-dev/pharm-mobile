import 'package:equatable/equatable.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart' show Brand, Category;
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

class ParaPharmFilters extends Equatable {
  final ParaPharmSearchByFields searchByField;
  final Brand? brand;
  final Category? category;
  final double minPriceFilter;
  final double maxPriceFilter;

  const ParaPharmFilters({
    this.searchByField = ParaPharmSearchByFields.name,
    this.brand,
    this.category,
    this.minPriceFilter = 0.0,
    this.maxPriceFilter = 0.0,
  });

  ParaPharmFilters copyWith({
    ParaPharmSearchByFields? searchByField,
    double? minPriceFilter,
    double? maxPriceFilter,
    Brand? brand,
    Category? category,
  }) {
    return ParaPharmFilters(
      searchByField: searchByField ?? this.searchByField,
      minPriceFilter: minPriceFilter ?? this.minPriceFilter,
      maxPriceFilter: maxPriceFilter ?? this.maxPriceFilter,
      brand: brand,
      category: category,
    );
  }

  bool compare(ParaPharmFilters filters) {
    return searchByField == filters.searchByField &&
        minPriceFilter == filters.minPriceFilter &&
        maxPriceFilter == filters.maxPriceFilter &&
        category == filters.category &&
        brand == filters.brand;
  }

  @override
  List<Object?> get props => [category, brand, searchByField, minPriceFilter, maxPriceFilter];
}
