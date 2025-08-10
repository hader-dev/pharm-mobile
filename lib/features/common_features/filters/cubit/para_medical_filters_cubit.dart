import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/models/para_medical_filters.dart';
import 'package:hader_pharm_mobile/repositories/locale/filters/filters_repository.dart';
import 'package:hader_pharm_mobile/repositories/locale/filters/params/params_load_filters.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';
part 'para_medical_filters_state.dart';

class ParaMedicalFiltersCubit extends Cubit<ParaMedicalFiltersState> {
  late final IFiltersRepository _filtersRepository;

  int _pageIndex = 0;
  get pageIndex => _pageIndex;

  final searchController = TextEditingController();



  ParaMedicalFilters filtersSource = const ParaMedicalFilters();
  ParaMedicalFilters appliedFilters = const ParaMedicalFilters();
  ParaMedicalFilters visibleFilters = const ParaMedicalFilters();

  ParaMedicalFiltersKeys currentkey = ParaMedicalFiltersKeys.distributorSku;

  ParaMedicalFiltersCubit({required IFiltersRepository filtersRepository})
      : super(ParaMedicalFiltersStateInitial()) {
    _filtersRepository = filtersRepository;
  }

  void loadParaMedicalFilters([ParamsLoadFiltersParaMedical? params]) async {
    try {
      emit(ParaMedicalFiltersIsLoading());
      final data = await _filtersRepository
          .getParaMedicalFilters(params ?? ParamsLoadFiltersParaMedical());
      filtersSource = data.filters;
      visibleFilters = data.filters.copyWith();
      emit(ParaMedicalFiltersLoaded());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(ParaMedicalFiltersLoadingError());
    }
  }

  void updateVisibleItems() {
    visibleFilters =
        filtersSource.updateSearchFilter(currentkey, searchController.text);
    emit(ParaMedicalFiltersUpdated());
  }

  List<String> getCurrentWorkSourceFilters() {
    return visibleFilters.getFilterBykey(currentkey);
  }

  List<String> getCurrentWorkAppliedFilters() {
    return appliedFilters.getFilterBykey(currentkey);
  }

  void updatedAppliedFilters(String value, bool isSelected) {
    final vFilters = [...appliedFilters.getFilterBykey(currentkey)];
    if (isSelected) {
      vFilters.add(value);
    } else {
      vFilters.remove(value);
    }

    appliedFilters = appliedFilters.updateFilterList(currentkey, vFilters);

    emit(ParaMedicalFiltersUpdated());
  }

  void goToAllFilters() {
    _pageIndex = 0;
    emit(ParaMedicalFiltersPageChanged());
  }

  void goToApplyFilters(ParaMedicalFiltersKeys key) {
    _pageIndex = 1;
    currentkey = key;
    emit(ParaMedicalFiltersPageChanged());
  }
  void updatePriceRange(double minPrice, double maxPrice) {
  appliedFilters = appliedFilters.copyWith(
    gteUnitPriceHt: minPrice.toString(),
    lteUnitPriceHt: maxPrice.toString(),
  );
  emit(ParaMedicalFiltersUpdated()); 
}



  void resetCurrentFilters() {
    if (currentkey == ParaMedicalFiltersKeys.unitPriceHt) {
      // Reset price filters
      appliedFilters = appliedFilters.copyWith(
        gteUnitPriceHt: null,
        lteUnitPriceHt: null,
      );
    } else {
      // Reset normal filters
      appliedFilters = appliedFilters.updateFilterList(currentkey, []);
      searchController.clear();
      updateVisibleItems();
    }
    emit(ParaMedicalFiltersUpdated());
  }

  void resetAllFilters() {
    appliedFilters = const ParaMedicalFilters();
    searchController.clear();
    emit(ParaMedicalFiltersUpdated());
  }
}
