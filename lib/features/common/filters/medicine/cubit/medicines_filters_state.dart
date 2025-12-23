part of 'medicines_filters_cubit.dart';

sealed class MedicinesFiltersState {
  const MedicinesFiltersState();
}

final class MedicinesFiltersInitial extends MedicinesFiltersState {}

final class MedicinesFiltersChanged extends MedicinesFiltersState {}
