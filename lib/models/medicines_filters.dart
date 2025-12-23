import 'package:equatable/equatable.dart';
import 'package:hader_pharm_mobile/utils/enums.dart' show SearchMedicinesByFields;

class MedicinesFilters extends Equatable {
  final SearchMedicinesByFields searchByFields;

  final double minPriceFilter;
  final double maxPriceFilter;

  const MedicinesFilters({
    this.searchByFields = SearchMedicinesByFields.dci,
    this.minPriceFilter = 0.0,
    this.maxPriceFilter = 0.0,
  });

  MedicinesFilters copyWith({
    SearchMedicinesByFields? searchByField,
    double? minPriceFilter,
    double? maxPriceFilter,
  }) {
    return MedicinesFilters(
      searchByFields: searchByField ?? searchByFields,
      minPriceFilter: minPriceFilter ?? this.minPriceFilter,
      maxPriceFilter: maxPriceFilter ?? this.maxPriceFilter,
    );
  }

  bool compare(MedicinesFilters filters) {
    return searchByFields == filters.searchByFields &&
        minPriceFilter == filters.minPriceFilter &&
        maxPriceFilter == filters.maxPriceFilter;
  }

  @override
  List<Object?> get props => [searchByFields, minPriceFilter, maxPriceFilter];
}
