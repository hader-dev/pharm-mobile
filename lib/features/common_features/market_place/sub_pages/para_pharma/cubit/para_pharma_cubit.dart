import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';

import '../../../../../../models/para_pharma.dart';
import '../../../../../../repositories/remote/favorite/favorite_repository_impl.dart';
import '../../../../../../repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';
import '../../../../../../utils/constants.dart';
import '../../../../../../utils/enums.dart';

part 'para_pharma_state.dart';

class ParaPharmaCubit extends Cubit<ParaPharmaState> {
  int totalItemsCount = 0;
  int offSet = 0;
  SearchParaPharmaFilters? selectedParaPharmaSearchFilter;
  List<BaseParaPharmaCatalogModel> paraPharmaProducts = [];
  final ParaPharmaRepository paraPharmaRepository;
  final TextEditingController searchController;
  final ScrollController scrollController;
  final FavoriteRepository favoriteRepository;
  Timer? _debounce;
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
      emit(ParaPharmaProductsLoading());
      var paraPharmaCatalogResponse = await paraPharmaRepository.getParaPharmaCatalog(
          offset: offset,
          searchFilter: selectedParaPharmaSearchFilter,
          search: searchValue,
          companyIdFilter: companyIdFilter);
      totalItemsCount = paraPharmaCatalogResponse.totalItems;
      paraPharmaProducts = paraPharmaCatalogResponse.data;
      emit(ParaPharmaProductsLoaded());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(ParaPharmaProductsLoadingFailed());
    }
  }

  Future<void> loadMoreParaPharmas() async {
    try {
      if (offSet >= totalItemsCount) {
        emit(ParaPharmasLoadLimitReached());
        return;
      }

      offSet = offSet + PaginationConstants.resultsPerPage;
      emit(ParaPharmaProductsLoading());
      var medicinesResponse = await paraPharmaRepository.getParaPharmaCatalog(
        offset: offSet,
        searchFilter: selectedParaPharmaSearchFilter,
        search: searchController.text,
      );
      totalItemsCount = medicinesResponse.totalItems;
      paraPharmaProducts.addAll(medicinesResponse.data);
      emit(ParaPharmaProductsLoaded());
    } catch (e) {
      offSet = offSet - PaginationConstants.resultsPerPage;
      emit(ParaPharmaProductsLoadingFailed());
    }
  }

  void changeParaPharmaSearchFilter(SearchParaPharmaFilters filter) {
    selectedParaPharmaSearchFilter = filter;
    emit(ParaPharmaSearchFilterChanged());
  }

  void searchParaPharmaCatalog(String? text) => _debounceFunction(() => getParaPharmas(searchValue: text ?? ''));

  Future<void> _debounceFunction(Future<void> Function() func, [int milliseconds = 500]) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: milliseconds), () async {
      await func();
      _debounce = null;
    });
  }

  resetParaPharmaSearchFilter() {
    selectedParaPharmaSearchFilter = null;
    getParaPharmas();
    emit(ParaPharmaSearchFilterChanged());
  }

  Future<void> likeParaPharmaCatalog(String paraPharmaCatalogId) async {
    var index = paraPharmaProducts.lastIndexWhere((paraProd) => paraProd.id == paraPharmaCatalogId);
    try {
      paraPharmaProducts[index].isLiked = true;
      await favoriteRepository.likeParaPharmaCatalog(paraPharmaCatalogId: paraPharmaCatalogId);

      emit(ParaPharmaLiked(paraPharmaId: paraPharmaCatalogId));
    } catch (e) {
      paraPharmaProducts[index].isLiked = false;
      GlobalExceptionHandler.handle(exception: e);
      emit(ParaPharmaLikeFailed(paraPharmaId: paraPharmaCatalogId));
    }
  }

  Future<void> unlikeParaPharmaCatalog(String paraPharmaCatalogId) async {
    var index = paraPharmaProducts.lastIndexWhere((paraProd) => paraProd.id == paraPharmaCatalogId);
    try {
      paraPharmaProducts[index].isLiked = false;
      await favoriteRepository.unLikeParaPharmaCatalog(paraPharmaCatalogId: paraPharmaCatalogId);
      emit(ParaPharmaLiked(paraPharmaId: paraPharmaCatalogId));
    } catch (e) {
      paraPharmaProducts[index].isLiked = true;
      GlobalExceptionHandler.handle(exception: e);
      emit(ParaPharmaLikeFailed(paraPharmaId: paraPharmaCatalogId));
    }
  }

  _onScroll() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
        if (offSet < totalItemsCount) {
          await loadMoreParaPharmas();
        } else {
          emit(ParaPharmasLoadLimitReached());
        }
      }
    });
  }
}
