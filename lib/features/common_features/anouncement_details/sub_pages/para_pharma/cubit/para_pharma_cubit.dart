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
import 'package:hader_pharm_mobile/utils/enums.dart';

part 'para_pharma_state.dart';

class ParaPharmaCubit extends Cubit<ParaPharmaState> {
  final ParaPharmaRepository paraPharmaRepository;
  final FavoriteRepository favoriteRepository;
  Timer? _debounce;
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
  Future<void> getParaPharmas({
    int offset = 0,
    String searchValue = '',
    String? companyIdFilter,
  }) async {
    try {
      emit(state.toLoading());
      var paraPharmaCatalogResponse =
          await paraPharmaRepository.getParaPharmaCatalog(ParamsLoadParapharma(
        offset: offset,
        filters: state.filters,
      ));
      final totalItemsCount = paraPharmaCatalogResponse.totalItems;
      final paraPharmaProducts = paraPharmaCatalogResponse.data;
      emit(state.toLoaded(
        paraPharmaProducts: paraPharmaProducts,
        totalItemsCount: totalItemsCount,
      ));
    } catch (e) {
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

      final offSet = state.offSet + PaginationConstants.resultsPerPage;
      emit(state.toLoading());
      var medicinesResponse = await paraPharmaRepository.getParaPharmaCatalog(
          ParamsLoadParapharma(offset: offSet, filters: state.filters));
      final totalItemsCount = medicinesResponse.totalItems;
      final paraPharmaProducts = state.paraPharmaProducts;
      paraPharmaProducts.addAll(medicinesResponse.data);
      emit(state.toLoaded(
        paraPharmaProducts: paraPharmaProducts,
        totalItemsCount: totalItemsCount,
      ));
    } catch (e) {
      emit(state.toLoadingFailed());
    }
  }

  void changeParaPharmaSearchFilter(SearchParaPharmaFilters filter) {
    emit(state.toSearchFilterChanged(
      selectedParaPharmaSearchFilter: filter,
    ));
  }

  void searchParaPharmaCatalog(String? text) =>
      _debounceFunction(() => getParaPharmas(searchValue: text ?? ''));

  Future<void> _debounceFunction(Future<void> Function() func,
      [int milliseconds = 500]) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: milliseconds), () async {
      await func();
      _debounce = null;
    });
  }

  void resetParaPharmaSearchFilter() {
    getParaPharmas();
    emit(state.toSearchFilterChanged(
      selectedParaPharmaSearchFilter: null,
      filters: const ParaMedicalFilters(),
    ));
  }

  void updatedFilters(ParaMedicalFilters appliedFilters) {
    emit(state.toSearchFilterChanged(
      selectedParaPharmaSearchFilter: state.selectedParaPharmaSearchFilter,
      filters: appliedFilters,
    ));
  }

  Future<void> likeParaPharmaCatalog(String paraPharmaCatalogId) async {
    try {
      await favoriteRepository.likeParaPharmaCatalog(
          paraPharmaCatalogId: paraPharmaCatalogId);

      emit(state.toLiked(paraPharmaId: paraPharmaCatalogId, liked: true));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.tolikeFailed(paraPharmaId: paraPharmaCatalogId));
    }
  }

  Future<void> unlikeParaPharmaCatalog(String paraPharmaCatalogId) async {
    try {
      await favoriteRepository.unLikeParaPharmaCatalog(
          paraPharmaCatalogId: paraPharmaCatalogId);
      emit(state.toLiked(paraPharmaId: paraPharmaCatalogId, liked: false));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.tolikeFailed(paraPharmaId: paraPharmaCatalogId));
    }
  }

  void _onScroll() {
    state.scrollController.addListener(() async {
      if (state.scrollController.position.pixels >=
          state.scrollController.position.maxScrollExtent) {
        if (state.offSet < state.totalItemsCount) {
          await loadMoreParaPharmas();
        } else {
          emit(state.toLoadLimitReached());
        }
      }
    });
  }
}
