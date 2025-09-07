import 'dart:async' show Timer;

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
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
  final ScrollController scrollController;
  final TextEditingController searchController;

  MedicineProductsCubit(
      {required this.medicineRepository,
      required this.favoriteRepository,
      required this.scrollController,
      required this.searchController})
      : super(MedicineProductsInitial()) {
    _onScroll();
  }
  Future<void> getMedicines({
    int offset = 0,
    String? companyIdFilter,
  }) async {
    try {
      emit(state.loading(offset: offset));
      var medicinesResponse = await medicineRepository.getMedicinesCatalog(
        offset: offset,
        filters: state.params,
        companyId: companyIdFilter,
      );
      emit(state.loaded(
          medicines: medicinesResponse.data,
          totalItemsCount: medicinesResponse.totalItems));
    } catch (e) {
      emit(state.loadingFailed());
    }
  }

  Future<void> loadMoreMedicines() async {
    try {
      if (state.offSet >= state.totalItemsCount) {
        emit(state.loadLimitReached());
        return;
      }

      final newOffset = state.offSet + PaginationConstants.resultsPerPage;
      emit(state.loadingMore());
      var medicinesResponse = await medicineRepository.getMedicinesCatalog(
        offset: newOffset,
        filters: state.params,
      );
      final updatedMedicines = [...state.medicines, ...medicinesResponse.data];
      emit(state.loaded(
          medicines: updatedMedicines,
          totalItemsCount: medicinesResponse.totalItems));
    } catch (e) {
      emit(state.loadingFailed());
    }
  }

  resetMedicinesSearchFilter() {
    emit(state.searchFilterChanged(
        searchFilter: SearchMedicineFilters.dci,
        params: const MedicalFilters()));
    getMedicines();
  }

  void changeMedicineSearchFilter(SearchMedicineFilters filter) {
    emit(state.searchFilterChanged(searchFilter: filter));
  }

  void searchMedicineCatalog(String? text) =>
      _debounceFunction(() => getMedicines());

  Future<void> _debounceFunction(Future<void> Function() func,
      [int milliseconds = 500]) async {
    if (state.debounce?.isActive ?? false) state.debounce?.cancel();
    final timer = Timer(Duration(milliseconds: milliseconds), () async {
      await func();
    });
    emit(state.copyWith(debounce: timer));
  }

  Future<void> likeMedicinesCatalog(String medicineCatalogId) async {
    try {
      await favoriteRepository.likeMedicineCatalog(
          medicineCatalogId: medicineCatalogId);
      emit(state.liked(medicineId: medicineCatalogId, isLiked: true));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.likeFailed(medicineId: medicineCatalogId));
    }
  }

  Future<void> unlikeMedicinesCatalog(String medicineCatalogId) async {
    try {
      await favoriteRepository.unLikeMedicineCatalog(
          medicineCatalogId: medicineCatalogId);
      emit(state.liked(medicineId: medicineCatalogId, isLiked: false));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.likeFailed(medicineId: medicineCatalogId));
    }
  }

  _onScroll() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (state.offSet < state.totalItemsCount) {
          await loadMoreMedicines();
        } else {
          emit(state.loadLimitReached());
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
        emit(state.scroll(offset: currentOffset, displayFilters: newDisplayFilters));
      }
    });
  }

  void updatedFilters(MedicalFilters appliedFilters) {
    emit(state.copyWith(params: appliedFilters));
  }
}
