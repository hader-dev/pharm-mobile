import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';

import '../../../../../../models/para_pharma.dart';
import '../../../../../../repositories/remote/parapharm_catalog/para_pharma_catalog_repository_impl.dart';
import '../../../../../../utils/constants.dart';

part 'para_pharma_state.dart';

class ParaPharmaCubit extends Cubit<ParaPharmaState> {
  int totalItemsCount = 0;
  int offSet = 0;
  List<BaseParaPharmaCatalogModel> paraPharmaProducts = [];
  final ParaPharmaRepository paraPharmaRepository;
  final ScrollController scrollController;
  ParaPharmaCubit({required this.paraPharmaRepository, required this.scrollController}) : super(ParaPharmaInitial()) {
    _onScroll();
  }
  Future<void> getParaPharmas({
    int offset = 0,
  }) async {
    try {
      emit(ParaPharmaProductsLoading());
      var paraPharmaCatalogResponse = await paraPharmaRepository.getParaPharmaCatalog(
        offset: offset,
      );
      totalItemsCount = paraPharmaCatalogResponse.totalItems;
      paraPharmaProducts = paraPharmaCatalogResponse.data;
      emit(ParaPharmaProductsLoaded());
    } catch (e) {
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
      );
      totalItemsCount = medicinesResponse.totalItems;
      paraPharmaProducts.addAll(medicinesResponse.data);
      emit(ParaPharmaProductsLoaded());
    } catch (e) {
      offSet = offSet - PaginationConstants.resultsPerPage;
      emit(ParaPharmaProductsLoadingFailed());
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
