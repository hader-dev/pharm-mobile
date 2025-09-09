import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/models/para_medical_filters.dart';
import 'package:hader_pharm_mobile/repositories/remote/filters/filters_repository.dart';
import 'package:hader_pharm_mobile/repositories/remote/filters/params/param_load_para_medical_fitlers.dart';
import 'package:hader_pharm_mobile/repositories/remote/filters/params/params_load_medical_filters.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';

part 'para_medical_filters_state.dart';

class ParaMedicalFiltersCubit extends Cubit<ParaMedicalFiltersState> {
  late final IFiltersRepository _filtersRepository;

  int _pageIndex = 0;
  get pageIndex => _pageIndex;

  final searchController = TextEditingController();
  Timer? _searchDebounceTimer;
  Timer? _searchDebounceTimer;

  ParaMedicalFilters filtersSource = const ParaMedicalFilters();
  ParaMedicalFilters appliedFilters = const ParaMedicalFilters();

  ParaMedicalFiltersKeys currentkey = ParaMedicalFiltersKeys.name;

  ParaMedicalFiltersCubit({required IFiltersRepository filtersRepository})
      : super(ParaMedicalFiltersStateInitial()) {
    _filtersRepository = filtersRepository;
  }

  void loadParaMedicalFilters([ParamsLoadFiltersParaMedical? params]) async {
    try {
      emit(ParaMedicalFiltersIsLoading());
      final data = await _filtersRepository.getParaMedicalFilter(
          ParamLoadParaMedicalFilter(
              key: currentkey, query: searchController.text));

      filtersSource = filtersSource.updateFilterList(currentkey, data.data);

      emit(ParaMedicalFiltersLoaded());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(ParaMedicalFiltersLoadingError());
    }
  }

  void updateVisibleItems() {
    emit(ParaMedicalFiltersUpdated());
  }

  List<String> getCurrentWorkSourceFilters() {
    if (currentkey == ParaMedicalFiltersKeys.unitPriceHt) {
      return [];
    }
    if (currentkey == ParaMedicalFiltersKeys.unitPriceHt) {
      return [];
    }
    return filtersSource.getFilterBykey(currentkey);
  }

  List<String> getCurrentWorkAppliedFilters() {
    if (currentkey == ParaMedicalFiltersKeys.unitPriceHt) {
      return [];
    }
    if (currentkey == ParaMedicalFiltersKeys.unitPriceHt) {
      return [];
    }
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
    _refreshFiltersForCurrentKey();
  }

  void resetPriceFilter() {
    appliedFilters = appliedFilters.copyWith(
      resetGteUnitPriceHt: true,
      resetLteUnitPriceHt: true,
    );
    emit(ParaMedicalFiltersUpdated());
  }

  void _refreshFiltersForCurrentKey() {
    if (currentkey == ParaMedicalFiltersKeys.name &&
        filtersSource.getFilterBykey(currentkey).isEmpty) {
      loadParaMedicalFilters();
    } else if (currentkey != ParaMedicalFiltersKeys.unitPriceHt) {
      loadParaMedicalFilters();
    }
  }

  void updatePriceRange(double minPrice, double maxPrice) {
    appliedFilters = appliedFilters.copyWith(
      gteUnitPriceHt: minPrice.toString(),
      lteUnitPriceHt: maxPrice.toString(),
    );
    emit(ParaMedicalFiltersUpdated());
  }

  void updateFilterKey(ParaMedicalFiltersKeys key) {
    currentkey = key;
    loadParaMedicalFilters();
    emit(ParaMedicalFiltersUpdated());
  }

  void resetCurrentFilters() {
    if (currentkey == ParaMedicalFiltersKeys.unitPriceHt) {
      appliedFilters = appliedFilters.copyWith(
        resetGteUnitPriceHt: true,
        resetLteUnitPriceHt: true,
        resetGteUnitPriceHt: true,
        resetLteUnitPriceHt: true,
      );
    } else {
      appliedFilters = appliedFilters.updateFilterList(currentkey, []);
      searchController.clear();
      loadParaMedicalFilters();
      loadParaMedicalFilters();
    }
    emit(ParaMedicalFiltersUpdated());
  }

  void resetAllFilters() {
    appliedFilters = const ParaMedicalFilters();
    searchController.clear();

    loadParaMedicalFilters();
    emit(ParaMedicalFiltersUpdated());
    emit(ParaMedicalFiltersUpdated());
  }

  void clearSearch() {
    searchController.clear();
    loadParaMedicalFilters();
  }

  void onSearchChanged(String searchText) {
    _searchDebounceTimer?.cancel();

    if (searchController.text != searchText) {
      searchController.text = searchText;
    }

    _searchDebounceTimer = Timer(const Duration(milliseconds: 500), () {
      loadParaMedicalFilters();
    });
  }

  @override
  Future<void> close() {
    _searchDebounceTimer?.cancel();
    searchController.dispose();
    return super.close();
  }
}
