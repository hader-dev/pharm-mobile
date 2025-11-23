import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:hader_pharm_mobile/features/common_features/market_place/widgets/tabs_section.dart'
    show MarketPlaceTabBarSectionState;
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
  final ParaMedicalFilters defaultFilters;

  final DebouncerManager debouncerManager = DebouncerManager();
  bool _listenerAttached = false;

  ParaPharmaCubit(
      {required this.paraPharmaRepository,
      required ScrollController scrollController,
      required TextEditingController searchController,
      ParaMedicalFilters? filters,
      required this.favoriteRepository})
      : defaultFilters = filters ?? const ParaMedicalFilters(),
        super(ParaPharmaInitial(
          scrollController: scrollController,
          searchController: searchController,
          filters: filters ?? const ParaMedicalFilters(),
        )) {
    state.scrollController.addListener(() {
      if (state.scrollController.position.pixels > 5 &&
          state.scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        MarketPlaceTabBarSectionState.animationController.forward();
      }
      if (state.scrollController.position.pixels > 5 &&
          state.scrollController.position.userScrollDirection == ScrollDirection.forward) {
        MarketPlaceTabBarSectionState.animationController.reverse();
      }
      if (state.scrollController.position.pixels >= state.scrollController.position.maxScrollExtent) {
        loadMoreParaPharmas();
      }
    });
  }

  ScrollController get scrollController {
    if (!_listenerAttached) {
      state.scrollController.addListener(_onScroll);
      _listenerAttached = true;
    }
    return state.scrollController;
  }

  Future<void> getParaPharmas(
      {int offset = 0, String? searchValue, String? companyIdFilter, ParaMedicalFilters? filters}) async {
    try {
      emit(state.toLoading(filters: filters));

      debugPrint('Loading ParaPharma Catalog with filters: $filters and offset: $companyIdFilter');
      var paraPharmaCatalogResponse = await paraPharmaRepository.getParaPharmaCatalog(ParamsLoadParapharma(
        offset: offset,
        filters: filters ?? state.filters,
        searchQuery: searchValue ?? state.searchController.text,
        companyId: state.filters.vendors.isEmpty ? companyIdFilter : state.filters.vendors.first,
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

      emit(state.toLoadingMore(state.offSet + PaginationConstants.resultsPerPage));
      var medicinesResponse = await paraPharmaRepository.getParaPharmaCatalog(ParamsLoadParapharma(
          offset: state.offSet,
          filters: state.filters,
          companyId: state.filters.vendors.isEmpty ? null : state.filters.vendors.first,
          searchQuery: state.searchController.text));

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
    getParaPharmas(filters: defaultFilters, searchValue: null);

    emit(state.toSearchFilterChanged(
      searchFilter: null,
      filters: defaultFilters,
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
    final localScrollController = state.scrollController;

    if (localScrollController.position.pixels >= localScrollController.position.maxScrollExtent) {
      if (state.offSet < state.totalItemsCount) {
        loadMoreParaPharmas();
      } else {
        emit(state.toLoadLimitReached());
      }
    }

    final currentOffset = localScrollController.offset;
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
  }

  void refreshParaPharmaCatalogFavorite(String paraPharmaCatalogId, bool liked) {
    emit(state.toLiked(paraPharmaId: paraPharmaCatalogId, isLiked: liked));
  }
}
