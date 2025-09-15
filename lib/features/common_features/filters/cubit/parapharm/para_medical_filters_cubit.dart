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

  final searchController = TextEditingController();

  ParaMedicalFiltersCubit({required IFiltersRepository filtersRepository})
      : super(const ParaMedicalFiltersStateInitial()) {
    _filtersRepository = filtersRepository;
  }

  int get pageIndex => state.pageIndex;
  ParaMedicalFilters get filtersSource => state.filtersSource;
  ParaMedicalFilters get appliedFilters => state.appliedFilters;
  ParaMedicalFiltersKeys get currentkey => state.currentKey;

  void loadParaMedicalFilters([ParamsLoadFiltersParaMedical? params]) async {
    try {
      emit(state.loading());
      final data = await _filtersRepository.getParaMedicalFilter(
          ParamLoadParaMedicalFilter(
              key: currentkey, query: searchController.text));

      final updatedFiltersSource =
          filtersSource.updateFilterList(currentkey, data.data);

      emit(state.loaded(updatedFiltersSource: updatedFiltersSource));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.loadingError());
    }
  }

  void updateVisibleItems() {
    emit(state.updated());
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

    final updatedAppliedFilters =
        appliedFilters.updateFilterList(currentkey, vFilters);

    emit(state.updated(updatedAppliedFilters: updatedAppliedFilters));
  }

  void goToAllFilters() {
    emit(state.pageChanged(newPageIndex: 0));
  }

  void goToApplyFilters(ParaMedicalFiltersKeys key) {
    emit(state.copyWith(
      pageIndex: 1,
      currentKey: key,
    ));

    loadParaMedicalFilters();
  }

  void resetPriceFilter() {
    final updatedAppliedFilters = appliedFilters.copyWith(
      resetGteUnitPriceHt: true,
      resetLteUnitPriceHt: true,
    );
    emit(state.updated(updatedAppliedFilters: updatedAppliedFilters));
  }

  void updatePriceRange(double minPrice, double maxPrice) {
    final updatedAppliedFilters = appliedFilters.copyWith(
      gteUnitPriceHt: minPrice.toString(),
      lteUnitPriceHt: maxPrice.toString(),
    );
    emit(state.updated(updatedAppliedFilters: updatedAppliedFilters));
  }

  void updateFilterKey(ParaMedicalFiltersKeys key) {
    emit(state.copyWith(currentKey: key));
    loadParaMedicalFilters();
  }

  void initializePriceFilter() {
    emit(state.updated());
  }

  void resetCurrentFilters() {
    if (currentkey == ParaMedicalFiltersKeys.unitPriceHt) {
      final updatedAppliedFilters = appliedFilters.copyWith(
        resetGteUnitPriceHt: true,
        resetLteUnitPriceHt: true,
      );
      emit(state.updated(updatedAppliedFilters: updatedAppliedFilters));
    } else {
      final updatedAppliedFilters =
          appliedFilters.updateFilterList(currentkey, []);
      searchController.clear();
      emit(state.updated(updatedAppliedFilters: updatedAppliedFilters));
    }
  }

  void resetAllFilters() {
    const newAppliedFilters = ParaMedicalFilters();
    searchController.clear();

    emit(state.updated(updatedAppliedFilters: newAppliedFilters));
    loadParaMedicalFilters();
  }

  void clearSearch() {
    searchController.clear();
    loadParaMedicalFilters();
  }

  void onSearchChanged(String searchText) {
    state.searchDebounceTimer?.cancel();

    if (searchController.text != searchText) {
      searchController.text = searchText;
    }

    final newTimer = Timer(const Duration(milliseconds: 500), () {
      loadParaMedicalFilters();
    });

    emit(state.copyWith(searchDebounceTimer: newTimer));
  }

  @override
  Future<void> close() {
    state.searchDebounceTimer?.cancel();
    searchController.dispose();
    return super.close();
  }
}
