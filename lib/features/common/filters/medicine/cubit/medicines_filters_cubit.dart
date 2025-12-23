import 'package:bloc/bloc.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';

import '../../../../../models/medicines_filters.dart' show MedicinesFilters;

part 'medicines_filters_state.dart';

class MedicinesFiltersCubit extends Cubit<MedicinesFiltersState> {
  MedicinesFilters appliedFilters = const MedicinesFilters();
  MedicinesFilters tempFilters = const MedicinesFilters();
  MedicinesFiltersCubit() : super(MedicinesFiltersInitial());

  void initFilters(MedicinesFilters filters) {
    appliedFilters = filters;
    tempFilters = filters;
    emit(MedicinesFiltersChanged());
  }

  void changeFilters(MedicinesFilters filters) {
    tempFilters = filters;
    emit(MedicinesFiltersChanged());
  }

  void applyFilters() {
    appliedFilters = tempFilters;
    emit(MedicinesFiltersChanged());
  }

  void resetFilters() {
    appliedFilters = const MedicinesFilters();
    tempFilters = const MedicinesFilters();
    emit(MedicinesFiltersChanged());
  }

  void searchBrands(String text) {
    emit(MedicinesFiltersChanged());
  }
}
