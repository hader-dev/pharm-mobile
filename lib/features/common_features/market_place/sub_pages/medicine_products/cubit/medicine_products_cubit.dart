import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/repositories/remote/medicine_catalog/medicine_catalog_repository_impl.dart';

import '../../../../../../utils/constants.dart';

part 'medicine_products_state.dart';

class MedicineProductsCubit extends Cubit<MedicineProductsState> {
  int totalItemsCount = 0;
  int offSet = 0;
  List<BaseMedicineCatalog> medicines = [];
  final MedicineCatalogRepository medicineRepository;
  final ScrollController scrollController;
  MedicineProductsCubit({required this.medicineRepository, required this.scrollController})
      : super(MedicineProductsInitial()) {
    _onScroll();
  }
  Future<void> getMedicines({
    int offset = 0,
  }) async {
    try {
      emit(MedicineProductsLoading());
      var medicinesResponse = await medicineRepository.getMedicinesCatalog(
        offset: offset,
      );
      totalItemsCount = medicinesResponse.totalItems;
      medicines = medicinesResponse.data;
      emit(MedicineProductsLoaded());
    } catch (e) {
      emit(MedicineProductsLoadingFailed());
    }
  }

  Future<void> loadMoreMedicines() async {
    try {
      if (offSet >= totalItemsCount) {
        emit(MedicinesLoadLimitReached());
        return;
      }

      offSet = offSet + PaginationConstants.resultsPerPage;
      emit(MedicineProductsLoading());
      var medicinesResponse = await medicineRepository.getMedicinesCatalog(
        offset: offSet,
      );
      totalItemsCount = medicinesResponse.totalItems;
      medicines.addAll(medicinesResponse.data);
      emit(MedicineProductsLoaded());
    } catch (e) {
      offSet = offSet - PaginationConstants.resultsPerPage;
      emit(MedicineProductsLoadingFailed());
    }
  }

  _onScroll() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
        if (offSet < totalItemsCount) {
          await loadMoreMedicines();
        } else {
          emit(MedicinesLoadLimitReached());
        }
      }
    });
  }
}
