import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart' show RoutingManager;
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/para_pharma.dart'
    show ParaPharmaProductsPageState;
import 'package:hader_pharm_mobile/models/para_pharm_filters.dart';
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
  ParaPharmFilters appliedFilters;

  final DebounceManager debouncerManager = DebounceManager();
  bool _listenerAttached = false;

  ParaPharmaCubit(
      {required this.paraPharmaRepository,
      required ScrollController scrollController,
      required TextEditingController searchController,
      ParaPharmFilters? filters,
      required this.favoriteRepository})
      : appliedFilters = filters ?? const ParaPharmFilters(),
        super(ParaPharmaInitial(
          scrollController: scrollController,
          searchController: searchController,
        )) {
    state.scrollController.addListener(() {
      if (state.scrollController.position.maxScrollExtent >=
          MediaQuery.sizeOf(RoutingManager.rootNavigatorKey.currentContext!).height * .6) {
        if (state.scrollController.position.pixels > 5 &&
            state.scrollController.position.userScrollDirection == ScrollDirection.reverse) {
          ParaPharmaProductsPageState.animationController.forward();
        }
        if (state.scrollController.position.pixels > 5 &&
            state.scrollController.position.userScrollDirection == ScrollDirection.forward) {
          ParaPharmaProductsPageState.animationController.reverse();
        }
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

  Future<void> getParaPharms(
      {int offset = 0, String? searchValue, String? companyIdFilter, ParaPharmFilters? filters}) async {
    try {
      emit(state.toLoading(filters: filters));

      debugPrint('Loading ParaPharma Catalog with filters: $filters and offset: $companyIdFilter');
      var paraPharmaCatalogResponse = await paraPharmaRepository.getParaPharmaCatalog(ParamsLoadParapharma(
        offset: offset,
        filters: filters ?? state.filters,
        searchQuery: searchValue ?? state.searchController.text,
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

  void changeParaPharmSearchFilter(ParaPharmFilters filter) {
    emit(state.toSearchFilterChanged(filters: filter));
  }

  void searchParaPharmaCatalog(String? text) =>
      debouncerManager.debounce(tag: "search", action: () => getParaPharms(searchValue: text));

  void resetParaPharmaFilters() {
    appliedFilters = const ParaPharmFilters();

    getParaPharms(filters: appliedFilters, searchValue: null);

    emit(state.toSearchFilterChanged(
      filters: appliedFilters,
    ));
  }

  void updatedFilters(ParaPharmFilters appliedFilters) {
    emit(state.toSearchFilterChanged(
      filters: appliedFilters,
    ));
    getParaPharms(
      filters: appliedFilters,
    );
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

    // final currentOffset = localScrollController.offset;
    // final previousOffset = state.lastOffset;

    // bool displayFilters = state.displayFilters;

    // if (currentOffset > previousOffset && displayFilters) {
    //   displayFilters = false;
    // } else if (currentOffset < previousOffset && !displayFilters) {
    //   displayFilters = true;
    // }

    // if (displayFilters != state.displayFilters) {
    //   emit(state.toScroll(
    //     displayFilters: displayFilters,
    //     offset: currentOffset,
    //   ));
    // } else {
    //   emit(state.toScroll(
    //     displayFilters: state.displayFilters,
    //     offset: currentOffset,
    //   ));
    // }
  }

  void refreshParaPharmaCatalogFavorite(String paraPharmaCatalogId, bool liked) {
    emit(state.toLiked(paraPharmaId: paraPharmaCatalogId, isLiked: liked));
  }
}
