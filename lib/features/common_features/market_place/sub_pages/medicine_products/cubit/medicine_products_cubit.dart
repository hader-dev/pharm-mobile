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
  int totalItemsCount = 0;
  int offSet = 0;
  Timer? _debounce;
  SearchMedicineFilters? selectedMedicineSearchFilter;
  List<BaseMedicineCatalogModel> medicines = [];
  MedicalFilters params = const MedicalFilters();

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
  }) async {
    try {
      emit(MedicineProductsLoading());
      var medicinesResponse = await medicineRepository.getMedicinesCatalog(
          offset: offset, filters: params);
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
        filters: params,
      );
      totalItemsCount = medicinesResponse.totalItems;
      medicines.addAll(medicinesResponse.data);
      emit(MedicineProductsLoaded());
    } catch (e) {
      offSet = offSet - PaginationConstants.resultsPerPage;
      emit(MedicineProductsLoadingFailed());
    }
  }

  resetMedicinesSearchFilter() {
    selectedMedicineSearchFilter = null;
    params = const MedicalFilters();
    getMedicines();
    emit(MedicineSearchFilterChanged());
  }

  void changeMedicineSearchFilter(SearchMedicineFilters filter) {
    selectedMedicineSearchFilter = filter;
    emit(MedicineSearchFilterChanged());
  }

  void searchMedicineCatalog(String? text) =>
      _debounceFunction(() => getMedicines());

  Future<void> _debounceFunction(Future<void> Function() func,
      [int milliseconds = 500]) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: milliseconds), () async {
      await func();
      _debounce = null;
    });
  }

  Future<void> likeMedicinesCatalog(String medicineCatalogId) async {
    var index = medicines
        .lastIndexWhere((medicine) => medicine.id == medicineCatalogId);
    try {
      medicines[index].isLiked = true;
      await favoriteRepository.likeMedicineCatalog(
          medicineCatalogId: medicineCatalogId);

      emit(MedicineLiked(medicineId: medicineCatalogId));
    } catch (e) {
      medicines[index].isLiked = false;
      GlobalExceptionHandler.handle(exception: e);
      emit(MedicineLikeFailed(medicineId: medicineCatalogId));
    }
  }

  Future<void> unlikeMedicinesCatalog(String medicineCatalogId) async {
    var index = medicines
        .lastIndexWhere((medicine) => medicine.id == medicineCatalogId);
    try {
      medicines[index].isLiked = false;
      await favoriteRepository.unLikeMedicineCatalog(
          medicineCatalogId: medicineCatalogId);
      emit(MedicineLiked(medicineId: medicineCatalogId));
    } catch (e) {
      medicines[index].isLiked = true;
      GlobalExceptionHandler.handle(exception: e);
      emit(MedicineLikeFailed(medicineId: medicineCatalogId));
    }
  }

  _onScroll() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (offSet < totalItemsCount) {
          await loadMoreMedicines();
        } else {
          emit(MedicinesLoadLimitReached());
        }
      }
    });
  }

  void updatedFilters(MedicalFilters appliedFilters) {
    params = appliedFilters;
  }
}
