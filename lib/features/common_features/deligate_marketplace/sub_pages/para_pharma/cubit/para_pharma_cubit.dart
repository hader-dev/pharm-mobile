import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/models/para_medical_filters.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/repositories/remote/favorite/favorite_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/params/params_load_parapharma.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/debounce.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';

part 'para_pharma_state.dart';

class ParaPharmaCubit extends Cubit<ParaPharmaState> {
  final ParaPharmaRepository paraPharmaRepository;
  final FavoriteRepository favoriteRepository;

  final DebounceManager debouncerManager = DebounceManager();

  ParaPharmaCubit(
      {required this.paraPharmaRepository,
      required ScrollController scrollController,
      required TextEditingController searchController,
      required this.favoriteRepository})
      : super(ParaPharmaInitial(
          scrollController: scrollController,
          searchController: searchController,
        )) {
    _onScroll();
  }

  Future<void> getParaPharmas(
      {int offset = 0, String? searchValue, String? companyIdFilter, ParaMedicalFilters? filters}) async {
    try {
      emit(state.toLoading(filters: filters));
      var paraPharmaCatalogResponse = await paraPharmaRepository.getParaPharmaCatalog(ParamsLoadParapharma(
        offset: offset,
        filters: filters ?? state.filters,
        searchQuery: searchValue ?? state.searchController.text,
        companyId: companyIdFilter,
      ));

      emit(state.toLoaded(
          paraPharmaProducts: paraPharmaCatalogResponse.data, totalItemsCount: paraPharmaCatalogResponse.totalItems));
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      GlobalExceptionHandler.handle(exception: e);
      emit(state.toLoadingFailed());
    }
  }

  Future<void> loadMoreParaPharmas() async {
    try {
      if (state.offSet >= state.totalItemsCount) {
        emit(state.toLoadLimitReached());
        return;
      }

      emit(state.toLoading(offset: state.offSet + PaginationConstants.resultsPerPage));
      var medicinesResponse = await paraPharmaRepository.getParaPharmaCatalog(
          ParamsLoadParapharma(offset: state.offSet, filters: state.filters, searchQuery: state.searchController.text));

      final updatedProducts = List<BaseParaPharmaCatalogModel>.from(state.paraPharmaProducts);
      updatedProducts.addAll(medicinesResponse.data);

      emit(state.toLoaded(
        paraPharmaProducts: updatedProducts,
        totalItemsCount: medicinesResponse.totalItems,
      ));
    } catch (e) {
      emit(state.toLoadingFailed());
    }
  }

  void changeParaPharmaSearchFilter(SearchParaPharmaFilters filter) {
    emit(state.toSearchFilterChanged(searchFilter: filter));
  }

  void searchParaPharmaCatalog(String? text) =>
      debouncerManager.debounce(tag: "search", action: () => getParaPharmas(searchValue: text));

  void resetParaPharmaFilters() {
    getParaPharmas(filters: const ParaMedicalFilters(), searchValue: null);

    emit(state.toSearchFilterChanged(
      searchFilter: null,
      filters: const ParaMedicalFilters(),
    ));
  }

  void updatedFilters(ParaMedicalFilters appliedFilters) {
    emit(state.toSearchFilterChanged(
      filters: appliedFilters,
    ));
  }

  Future<void> likeParaPharmaCatalog(String paraPharmaCatalogId) async {
    try {
      await favoriteRepository.likeParaPharmaCatalog(paraPharmaCatalogId: paraPharmaCatalogId);

      emit(state.toLiked(paraPharmaId: paraPharmaCatalogId, isLiked: true));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.tolikeFailed(paraPharmaId: paraPharmaCatalogId));
    }
  }

  Future<void> unlikeParaPharmaCatalog(String paraPharmaCatalogId) async {
    try {
      await favoriteRepository.unLikeParaPharmaCatalog(paraPharmaCatalogId: paraPharmaCatalogId);
      emit(state.toLiked(paraPharmaId: paraPharmaCatalogId, isLiked: false));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.tolikeFailed(paraPharmaId: paraPharmaCatalogId));
    }
  }

  void _onScroll() {
    state.scrollController.addListener(() async {
      if (state.scrollController.position.pixels >= state.scrollController.position.maxScrollExtent) {
        if (state.offSet < state.totalItemsCount) {
          await loadMoreParaPharmas();
        } else {
          emit(state.toLoadLimitReached());
        }
      }

      final currentOffset = state.scrollController.offset;
      final previousOffset = state.lastOffset;

      bool displayFilters = state.displayFilters;

      if (currentOffset > previousOffset && displayFilters) {
        displayFilters = false;
      } else if (currentOffset < previousOffset && !displayFilters) {
        displayFilters = true;
      }

      if (displayFilters != state.displayFilters) {
        emit(state.toScroll(
          displayFilters: displayFilters,
          offset: currentOffset,
        ));
      } else {
        emit(state.toScroll(
          displayFilters: state.displayFilters,
          offset: currentOffset,
        ));
      }
    });
  }

  void refreshParaPharmaCatalogFavorite(String paraPharmaCatalogId, bool liked) {
    emit(state.toLiked(paraPharmaId: paraPharmaCatalogId, isLiked: liked));
  }
}
