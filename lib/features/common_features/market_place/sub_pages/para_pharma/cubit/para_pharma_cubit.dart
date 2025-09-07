import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/models/para_medical_filters.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/repositories/remote/favorite/favorite_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';

part 'para_pharma_state.dart';

class ParaPharmaCubit extends Cubit<ParaPharmaState> {
  final ParaPharmaRepository paraPharmaRepository;
  final FavoriteRepository favoriteRepository;
  final TextEditingController searchController;
  final ScrollController scrollController;

  ParaPharmaCubit(
      {required this.paraPharmaRepository,
      required this.scrollController,
      required this.searchController,
      required this.favoriteRepository})
      : super(ParaPharmaInitial()) {
    _onScroll();
  }

  Future<void> getParaPharmas({
    int offset = 0,
    String searchValue = '',
    String? companyIdFilter,
  }) async {
    try {
      emit(state.loading());
      var paraPharmaCatalogResponse =
          await paraPharmaRepository.getParaPharmaCatalog(
        offset: offset,
        filters: state.filters,
        companyId: companyIdFilter,
      );
      emit(state.loaded(
          paraPharmaProducts: paraPharmaCatalogResponse.data,
          totalItemsCount: paraPharmaCatalogResponse.totalItems));
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      GlobalExceptionHandler.handle(exception: e);
      emit(state.loadingFailed());
    }
  }

  Future<void> loadMoreParaPharmas() async {
    try {
      if (state.offSet >= state.totalItemsCount) {
        emit(state.loadLimitReached());
        return;
      }

      emit(state.loading(
          offset: state.offSet + PaginationConstants.resultsPerPage));
      var medicinesResponse = await paraPharmaRepository.getParaPharmaCatalog(
          offset: state.offSet, filters: state.filters);

      final updatedProducts =
          List<BaseParaPharmaCatalogModel>.from(state.paraPharmaProducts);
      updatedProducts.addAll(medicinesResponse.data);

      emit(state.loaded(
        paraPharmaProducts: updatedProducts,
        totalItemsCount: medicinesResponse.totalItems,
      ));
    } catch (e) {
      emit(state.loadingFailed());
    }
  }

  void changeParaPharmaSearchFilter(SearchParaPharmaFilters filter) {
    emit(state.searchFilterChanged(searchFilter: filter));
  }

  void searchParaPharmaCatalog(String? text) =>
      _debounceFunction(() => getParaPharmas(searchValue: text ?? ''));

  Future<void> _debounceFunction(Future<void> Function() func,
      [int milliseconds = 500]) async {
    if (state.debounce?.isActive ?? false) state.debounce?.cancel();

    emit(state.searchFilterChanged(
        debounce: Timer(Duration(milliseconds: milliseconds), () async {
      await func();
    })));
  }

  resetParaPharmaSearchFilter() {
    getParaPharmas();
    emit(state.searchFilterChanged(
      searchFilter: null,
      filters: const ParaMedicalFilters(),
    ));
  }

  void updatedFilters(ParaMedicalFilters appliedFilters) {
    emit(state.searchFilterChanged(
      filters: appliedFilters,
    ));
  }

  Future<void> likeParaPharmaCatalog(String paraPharmaCatalogId) async {
    try {
      await favoriteRepository.likeParaPharmaCatalog(
          paraPharmaCatalogId: paraPharmaCatalogId);

      emit(state.liked(paraPharmaId: paraPharmaCatalogId, isLiked: true));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.likeFailed(paraPharmaId: paraPharmaCatalogId));
    }
  }

  Future<void> unlikeParaPharmaCatalog(String paraPharmaCatalogId) async {
    try {
      await favoriteRepository.unLikeParaPharmaCatalog(
          paraPharmaCatalogId: paraPharmaCatalogId);
      emit(state.liked(paraPharmaId: paraPharmaCatalogId, isLiked: false));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.likeFailed(paraPharmaId: paraPharmaCatalogId));
    }
  }

  _onScroll() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (state.offSet < state.totalItemsCount) {
          await loadMoreParaPharmas();
        } else {
          emit(state.loadLimitReached());
        }
      }

      final currentOffset = scrollController.offset;
      final previousOffset = state.lastOffset;

      bool displayFilters = state.displayFilters;

      if (currentOffset > previousOffset && displayFilters) {
        displayFilters = false;
      } else if (currentOffset < previousOffset && !displayFilters) {
        displayFilters = true;
      }

      if (displayFilters != state.displayFilters) {
        emit(state.scroll(
          displayFilters: displayFilters,
          offset: currentOffset,
        ));
      } else {
        emit(state.scroll(
          displayFilters: state.displayFilters,
          offset: currentOffset,
        ));
      }
    });
  }
}
