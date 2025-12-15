import 'package:equatable/equatable.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart' show Brand;
import 'package:hader_pharm_mobile/utils/enums.dart' show SearchMedicinesByFields;

class MedicinesFilters extends Equatable {
  final SearchMedicinesByFields searchByFields;
  final Brand? brand;
  final double minPriceFilter;
  final double maxPriceFilter;

  const MedicinesFilters(
      {this.searchByFields = SearchMedicinesByFields.dci,
      this.minPriceFilter = 0.0,
      this.maxPriceFilter = 0.0,
      this.brand});

  MedicinesFilters copyWith({
    SearchMedicinesByFields? searchByField,
    Brand? brand,
    double? minPriceFilter,
    double? maxPriceFilter,
  }) {
    return MedicinesFilters(
        searchByFields: searchByField ?? searchByFields,
        minPriceFilter: minPriceFilter ?? this.minPriceFilter,
        maxPriceFilter: maxPriceFilter ?? this.maxPriceFilter,
        brand: brand ?? this.brand);
  }

  bool compare(MedicinesFilters filters) {
    return searchByFields == filters.searchByFields &&
        minPriceFilter == filters.minPriceFilter &&
        maxPriceFilter == filters.maxPriceFilter &&
        brand == filters.brand;
  }

  @override
  List<Object?> get props => [searchByFields, minPriceFilter, maxPriceFilter];
}
