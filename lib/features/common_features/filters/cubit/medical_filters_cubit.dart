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
    final data = filtersSource.getFilterBykey(currentkey);
    return data;
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
    searchController.clear();
    emit(MedicalFiltersPageChanged());

    loadMedicalFilters();
  }

  void resetCurrentFilters() {
    if (currentkey == MedicalFiltersKeys.unitPriceHt) {
      appliedFilters = appliedFilters.copyWith(
        gteUnitPriceHt: null,
        lteUnitPriceHt: null,
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
    emit(MedicalFiltersUpdated());
  }
}
