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
  final ParaMedicalFilters defaultFilters;

  ParaMedicalFiltersCubit(
      {required IFiltersRepository filtersRepository,
      ParaMedicalFilters? appliedFilters})
      : defaultFilters = appliedFilters ?? const ParaMedicalFilters(),
        super(ParaMedicalFiltersStateInitial(
            appliedFilters: appliedFilters ?? const ParaMedicalFilters())) {
    _filtersRepository = filtersRepository;
  }

  void loadParaMedicalFilters([ParamsLoadFiltersParaMedical? params]) async {
    try {
      emit(state.loading());
      final data = await _filtersRepository.getParaMedicalFilter(
          ParamLoadParaMedicalFilter(
              key: state.currentKey, query: searchController.text));

      final updatedstate =
          state.filtersSource.updateFilterList(state.currentKey, data.data);

      emit(state.loaded(updatedFiltersSource: updatedstate));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.loadingError());
    }
  }

  void updateVisibleItems() {
    emit(state.updated());
  }

  List<String> getCurrentWorkSourceFilters() {
    if (state.currentKey == ParaMedicalFiltersKeys.unitPriceHt) {
      return [];
    }
    if (state.currentKey == ParaMedicalFiltersKeys.unitPriceHt) {
      return [];
    }
    return state.filtersSource.getFilterBykey(state.currentKey);
  }

  List<String> getCurrentWorkAppliedFilters() {
    if (state.currentKey == ParaMedicalFiltersKeys.unitPriceHt) {
      return [];
    }
    if (state.currentKey == ParaMedicalFiltersKeys.unitPriceHt) {
      return [];
    }
    return state.appliedFilters.getFilterBykey(state.currentKey);
  }

  void updatedAppliedFilters(String value, bool isSelected) {
    final vFilters = [
      ...(state.appliedFilters.getFilterBykey(state.currentKey))
    ];
    if (isSelected) {
      vFilters.add(value);
    } else {
      vFilters.remove(value);
    }

    final updatedAppliedFilters =
        state.appliedFilters.updateFilterList(state.currentKey, vFilters);

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
    final updatedAppliedFilters = state.appliedFilters.copyWith(
      resetGteUnitPriceHt: true,
      resetLteUnitPriceHt: true,
    );
    emit(state.updated(updatedAppliedFilters: updatedAppliedFilters));
  }

  void updatePriceRange(double minPrice, double maxPrice) {
    final updatedAppliedFilters = state.appliedFilters.copyWith(
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
    if (state.currentKey == ParaMedicalFiltersKeys.unitPriceHt) {
      final updatedAppliedFilters = state.appliedFilters.copyWith(
        resetGteUnitPriceHt: true,
        resetLteUnitPriceHt: true,
      );
      emit(state.updated(updatedAppliedFilters: updatedAppliedFilters));
    } else {
      final updatedAppliedFilters =
          state.appliedFilters.updateFilterList(state.currentKey, []);
      searchController.clear();
      emit(state.updated(updatedAppliedFilters: updatedAppliedFilters));
    }
  }

  void resetAllFilters() {
    final newAppliedFilters = defaultFilters;
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
