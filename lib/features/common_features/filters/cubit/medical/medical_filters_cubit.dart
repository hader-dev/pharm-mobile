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

  final searchController = TextEditingController();

  MedicalFiltersCubit({required IFiltersRepository filtersRepository})
      : super(const MedicalFiltersStateInitial()) {
    _filtersRepository = filtersRepository;
  }

  int get pageIndex => state.pageIndex;
  MedicalFilters get filtersSource => state.filtersSource;
  MedicalFilters get appliedFilters => state.appliedFilters;
  MedicalFiltersKeys get currentkey => state.currentKey;

  void loadMedicalFilters() async {
    try {
      emit(state.loading());
      final data = await _filtersRepository.getMedicalFilter(
          ParamLoadMedicalFilter(
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

    final updatedAppliedFilters =
        appliedFilters.updateFilterList(currentkey, vFilters);

    emit(state.updated(updatedAppliedFilters: updatedAppliedFilters));
  }

  void updatePriceRange(double minPrice, double maxPrice) {
    final updatedAppliedFilters = appliedFilters.copyWith(
      gteUnitPriceHt: minPrice.toString(),
      lteUnitPriceHt: maxPrice.toString(),
    );
    emit(state.updated(updatedAppliedFilters: updatedAppliedFilters));
  }

  void goToAllFilters() {
    emit(state.pageChanged(newPageIndex: 0));
  }

  void goToApplyFilters(MedicalFiltersKeys key) {
    emit(state.copyWith(
      pageIndex: 1,
      currentKey: key,
    ));

    loadMedicalFilters();
  }

  void updateFilterKey(MedicalFiltersKeys key) {
    emit(state.copyWith(currentKey: key));
    loadMedicalFilters();
  }

  void initializePriceFilter() {
    emit(state.updated());
  }

  void resetPriceFilter() {
    final updatedAppliedFilters = appliedFilters.copyWith(
      resetGteUnitPriceHt: true,
      resetLteUnitPriceHt: true,
    );
    emit(state.updated(updatedAppliedFilters: updatedAppliedFilters));
  }

  void resetCurrentFilters() {
    if (currentkey == MedicalFiltersKeys.unitPriceHt) {
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
    const newAppliedFilters = MedicalFilters();
    searchController.clear();

    emit(state.updated(updatedAppliedFilters: newAppliedFilters));
    loadMedicalFilters();
  }

  void onSearchChanged(String searchText) {
    state.searchDebounceTimer?.cancel();

    if (searchController.text != searchText) {
      searchController.text = searchText;
    }

    final newTimer = Timer(const Duration(milliseconds: 500), () {
      loadMedicalFilters();
    });

    emit(state.copyWith(searchDebounceTimer: newTimer));
  }

  void clearSearch() {
    searchController.clear();
    loadMedicalFilters();
  }

  @override
  Future<void> close() {
    state.searchDebounceTimer?.cancel();
    return super.close();
  }
}
