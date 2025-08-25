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
  int totalItemsCount = 0;
  int offSet = 0;
  SearchParaPharmaFilters? selectedParaPharmaSearchFilter;
  List<BaseParaPharmaCatalogModel> paraPharmaProducts = [];
  ParaMedicalFilters filters = const ParaMedicalFilters();
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
      var paraPharmaCatalogResponse =
          await paraPharmaRepository.getParaPharmaCatalog(
        offset: offset,
        filters: filters,
        companyId: companyIdFilter,
      );
      totalItemsCount = paraPharmaCatalogResponse.totalItems;
      paraPharmaProducts = paraPharmaCatalogResponse.data;
      emit(ParaPharmaProductsLoaded());
    } catch (e, stack) {
      debugPrintStack(stackTrace: stack);
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
          offset: offSet, filters: filters);
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

  resetParaPharmaSearchFilter() {
    selectedParaPharmaSearchFilter = null;
    filters = const ParaMedicalFilters();
    getParaPharmas();
    emit(ParaPharmaSearchFilterChanged());
  }

  void updatedFilters(ParaMedicalFilters appliedFilters) {
    filters = appliedFilters;
  }

  Future<void> likeParaPharmaCatalog(String paraPharmaCatalogId) async {
    var index = paraPharmaProducts
        .lastIndexWhere((paraProd) => paraProd.id == paraPharmaCatalogId);
    try {
      paraPharmaProducts[index].isLiked = true;
      await favoriteRepository.likeParaPharmaCatalog(
          paraPharmaCatalogId: paraPharmaCatalogId);

      emit(ParaPharmaLiked(paraPharmaId: paraPharmaCatalogId));
    } catch (e) {
      paraPharmaProducts[index].isLiked = false;
      GlobalExceptionHandler.handle(exception: e);
      emit(ParaPharmaLikeFailed(paraPharmaId: paraPharmaCatalogId));
    }
  }

  Future<void> unlikeParaPharmaCatalog(String paraPharmaCatalogId) async {
    var index = paraPharmaProducts
        .lastIndexWhere((paraProd) => paraProd.id == paraPharmaCatalogId);
    try {
      paraPharmaProducts[index].isLiked = false;
      await favoriteRepository.unLikeParaPharmaCatalog(
          paraPharmaCatalogId: paraPharmaCatalogId);
      emit(ParaPharmaLiked(paraPharmaId: paraPharmaCatalogId));
    } catch (e) {
      paraPharmaProducts[index].isLiked = true;
      GlobalExceptionHandler.handle(exception: e);
      emit(ParaPharmaLikeFailed(paraPharmaId: paraPharmaCatalogId));
    }
  }

  _onScroll() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (offSet < totalItemsCount) {
          await loadMoreParaPharmas();
        } else {
          emit(ParaPharmasLoadLimitReached());
        }
      }
    });
  }
}
