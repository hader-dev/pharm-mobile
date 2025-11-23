import 'dart:async' show Timer;

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:flutter/widgets.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/widgets/tabs_section.dart'
    show MarketPlaceTabBarSectionState;
import 'package:hader_pharm_mobile/models/medical_filters.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/repositories/remote/favorite/favorite_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/medicine_catalog/medicine_catalog_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';

part 'medicine_products_state.dart';

class MedicineProductsCubit extends Cubit<MedicineProductsState> {
  final MedicineCatalogRepository medicineRepository;
  final FavoriteRepository favoriteRepository;
  bool _listenerAttached = false;
  final MedicalFilters defaultFilters;

  MedicineProductsCubit(
      {required this.medicineRepository,
      required this.favoriteRepository,
      required ScrollController scrollController,
      required TextEditingController searchController,
      MedicalFilters? filters})
      : defaultFilters = filters ?? const MedicalFilters(),
        super(MedicineProductsInitial(
            params: filters ?? const MedicalFilters(),
            searchController: searchController,
            scrollController: scrollController));

  ScrollController get scrollController {
    if (!_listenerAttached) {
      state.scrollController.addListener(_onScroll);
      _listenerAttached = true;
    }
    return state.scrollController;
  }

  Future<void> getMedicines({int offset = 0, String? companyIdFilter, MedicalFilters? filters}) async {
    try {
      emit(state.toLoading(offset: offset));
      var medicinesResponse = await medicineRepository.getMedicinesCatalog(
        offset: offset,
        filters: filters ?? state.params,
        companyId: companyIdFilter,
        searchValue: state.searchController.text,
      );
      emit(state.toLoaded(medicines: medicinesResponse.data, totalItemsCount: medicinesResponse.totalItems));
    } catch (e) {
      emit(state.toLoadingFailed());
    }
  }

  Future<void> loadMoreMedicines() async {
    try {
      if (state.offSet >= state.totalItemsCount) {
        emit(state.toLoadLimitReached());
        return;
      }

      final newOffset = state.offSet + PaginationConstants.resultsPerPage;
      emit(state.toLoadingMore(newOffset));
      var medicinesResponse = await medicineRepository.getMedicinesCatalog(
        offset: newOffset,
        filters: state.params,
        searchValue: state.searchController.text,
      );
      final updatedMedicines = [...state.medicines, ...medicinesResponse.data];
      emit(state.toLoaded(medicines: updatedMedicines, totalItemsCount: medicinesResponse.totalItems));
    } catch (e) {
      emit(state.toLoadingFailed());
    }
  }

  void resetMedicinesSearchFilter() {
    getMedicines(filters: defaultFilters);

    emit(
      state.toSearchFilterChanged(
        searchFilter: SearchMedicineFilters.dci,
        params: defaultFilters,
      ),
    );
  }

  void changeMedicineSearchFilter(SearchMedicineFilters filter) {
    emit(state.toSearchFilterChanged(searchFilter: filter));
  }

  void searchMedicineCatalog(String? text) => _debounceFunction(() => getMedicines());

  Future<void> _debounceFunction(Future<void> Function() func, [int milliseconds = 500]) async {
    if (state.debounce?.isActive ?? false) state.debounce?.cancel();
    final timer = Timer(Duration(milliseconds: milliseconds), () async {
      await func();
    });
    emit(state.toSearchFilterChanged(debounce: timer));
  }

  Future<void> likeMedicinesCatalog(String medicineCatalogId) async {
    try {
      await favoriteRepository.likeMedicineCatalog(medicineCatalogId: medicineCatalogId);
      emit(state.toLiked(medicineId: medicineCatalogId, isLiked: true));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.toLikeFailed(medicineId: medicineCatalogId));
    }
  }

  Future<void> unlikeMedicinesCatalog(String medicineCatalogId) async {
    try {
      await favoriteRepository.unLikeMedicineCatalog(medicineCatalogId: medicineCatalogId);
      emit(state.toLiked(medicineId: medicineCatalogId, isLiked: false));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.toLikeFailed(medicineId: medicineCatalogId));
    }
  }

  void _onScroll() {
    if (state.scrollController.position.pixels > 5 &&
        state.scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      MarketPlaceTabBarSectionState.animationController.forward();
    }
    if (state.scrollController.position.pixels > 5 &&
        state.scrollController.position.userScrollDirection == ScrollDirection.forward) {
      MarketPlaceTabBarSectionState.animationController.reverse();
    }
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
      if (state.offSet < state.totalItemsCount) {
        loadMoreMedicines();
      } else {
        emit(state.toLoadLimitReached());
      }
    }

    final currentOffset = scrollController.offset;
    bool newDisplayFilters = state.displayFilters;

    if (currentOffset > state.lastOffset) {
      newDisplayFilters = false;
    } else if (currentOffset < state.lastOffset) {
      newDisplayFilters = true;
    }

    if (newDisplayFilters != state.displayFilters) {
      emit(state.toScroll(offset: currentOffset, displayFilters: newDisplayFilters));
    }
  }

  void updatedFilters(MedicalFilters appliedFilters) {
    emit(state.toSearchFilterChanged(params: appliedFilters));
  }

  void refreshMedicineCatalogFavorite(String id, bool bool) {
    emit(state.toLiked(medicineId: id, isLiked: bool));
  }
}
