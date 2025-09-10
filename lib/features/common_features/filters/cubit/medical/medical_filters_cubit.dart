import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/models/medical_filters.dart';
import 'package:hader_pharm_mobile/repositories/remote/filters/filters_repository.dart';
import 'package:hader_pharm_mobile/repositories/remote/filters/params/params_load_medical_filters.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';

part 'medical_filters_state.dart';

class MedicalFiltersCubit extends Cubit<MedicalFiltersState> {
  late final IFiltersRepository _filtersRepository;

  int _pageIndex = 0;
  get pageIndex => _pageIndex;

  final searchController = TextEditingController();
  Timer? _searchDebounceTimer;

  MedicalFilters filtersSource = MedicalFilters();
  MedicalFilters appliedFilters = MedicalFilters();

  MedicalFiltersKeys currentkey = MedicalFiltersKeys.dci;

  MedicalFiltersCubit({required IFiltersRepository filtersRepository})
      : super(MedicalFiltersStateInitial()) {
    _filtersRepository = filtersRepository;
  }

  void loadMedicalFilters() async {
    try {
      emit(MedicalFiltersIsLoading());
      final data = await _filtersRepository.getMedicalFilter(
          ParamLoadMedicalFilter(
              key: currentkey, query: searchController.text));

      filtersSource = filtersSource.updateFilterList(currentkey, data.data);

      emit(MedicalFiltersLoaded());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(MedicalFiltersLoadingError());
    }
  }

  void updateVisibleItems() {
    emit(MedicalFiltersUpdated());
  }

  List<String> getCurrentWorkSourceFilters() {
    if (currentkey == MedicalFiltersKeys.unitPriceHt) {
      return [];
    }
    return filtersSource.getFilterBykey(currentkey);
  }

  List<String> getCurrentWorkAppliedFilters() {
    if (currentkey == MedicalFiltersKeys.unitPriceHt) {
      return [];
    }
    if (currentkey == MedicalFiltersKeys.unitPriceHt) {
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

    emit(MedicalFiltersUpdated());
  }

  void updatePriceRange(double minPrice, double maxPrice) {
    appliedFilters = appliedFilters.copyWith(
      gteUnitPriceHt: minPrice.toString(),
      lteUnitPriceHt: maxPrice.toString(),
    );
    emit(MedicalFiltersUpdated());
  }

  void goToAllFilters() {
    _pageIndex = 0;
    emit(MedicalFiltersPageChanged());
  }

  void goToApplyFilters(MedicalFiltersKeys key) {
    _pageIndex = 1;
    currentkey = key;

    loadMedicalFilters();

    emit(MedicalFiltersPageChanged());
  }

  void updateFilterKey(MedicalFiltersKeys key) {
    currentkey = key;
    loadMedicalFilters();
    emit(MedicalFiltersUpdated());
  }

  void initializePriceFilter() {
    emit(MedicalFiltersUpdated());
  }

  void resetPriceFilter() {
    appliedFilters = appliedFilters.copyWith(
      resetGteUnitPriceHt: true,
      resetLteUnitPriceHt: true,
    );
    emit(MedicalFiltersUpdated());
  }

  void resetCurrentFilters() {
    if (currentkey == MedicalFiltersKeys.unitPriceHt) {
      appliedFilters = appliedFilters.copyWith(
        resetGteUnitPriceHt: true,
        resetLteUnitPriceHt: true,
      );
    } else {
      appliedFilters = appliedFilters.updateFilterList(currentkey, []);
      searchController.clear();
    }
    emit(MedicalFiltersUpdated());
  }

  void resetAllFilters() {
    appliedFilters = const MedicalFilters();
    searchController.clear();

    loadMedicalFilters();
    emit(MedicalFiltersUpdated());
  }

  void onSearchChanged(String searchText) {
    _searchDebounceTimer?.cancel();

    if (searchController.text != searchText) {
      searchController.text = searchText;
    }

    _searchDebounceTimer = Timer(const Duration(milliseconds: 500), () {
      loadMedicalFilters();
    });
  }

  void clearSearch() {
    searchController.clear();
    loadMedicalFilters();
  }

  @override
  Future<void> close() {
    _searchDebounceTimer?.cancel();
    return super.close();
  }
}
