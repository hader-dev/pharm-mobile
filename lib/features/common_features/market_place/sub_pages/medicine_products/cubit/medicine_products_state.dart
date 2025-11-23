part of 'medicine_products_cubit.dart';

sealed class MedicineProductsState {
  final int totalItemsCount;
  final int offSet;
  final SearchMedicineFilters selectedMedicineSearchFilter;
  final List<BaseMedicineCatalogModel> medicines;
  final MedicalFilters params;
  final Timer? debounce;
  final double lastOffset;
  final bool displayFilters;
  final TextEditingController searchController;
  final ScrollController scrollController;

  const MedicineProductsState({
    required this.lastOffset,
    required this.debounce,
    required this.totalItemsCount,
    required this.scrollController,
    required this.offSet,
    required this.medicines,
    required this.displayFilters,
    required this.params,
    required this.searchController,
    required this.selectedMedicineSearchFilter,
  });

  bool get hasActiveFilters => params.isNotEmpty || hasPriceFilters || searchController.text.isNotEmpty;

  bool get hasPriceFilters =>
      (params.gteUnitPriceHt != null && params.gteUnitPriceHt != "0.0") ||
      (params.lteUnitPriceHt != null && params.lteUnitPriceHt != "100000.0");

  MedicineProductsInitial toInitial({
    double lastOffset = 0.0,
    dynamic debounce,
    int totalItemsCount = 0,
    int offSet = 0,
    List<BaseMedicineCatalogModel> medicines = const [],
    bool displayFilters = false,
    ScrollController? scrollController,
    MedicalFilters params = const MedicalFilters(),
    SearchMedicineFilters selectedMedicineSearchFilter = SearchMedicineFilters.dci,
  }) {
    return MedicineProductsInitial(
      lastOffset: lastOffset,
      debounce: debounce,
      searchController: searchController,
      totalItemsCount: totalItemsCount,
      offSet: offSet,
      medicines: medicines,
      displayFilters: displayFilters,
      params: params,
      scrollController: scrollController ?? ScrollController(),
      selectedMedicineSearchFilter: selectedMedicineSearchFilter,
    );
  }

  MedicineProductsLoading toLoading({int? offset}) => MedicineProductsLoading.fromState(
        state: this,
        offSet: offset,
      );

  MedicineLikeFailed toLikeFailed({required String medicineId}) =>
      MedicineLikeFailed.fromState(this, medicineId: medicineId);

  MedicineLiked toLiked({required String medicineId, required bool isLiked}) {
    final updated = medicines.map((element) {
      if (element.id == medicineId) {
        element.isLiked = isLiked;
        return element;
      }
      return element;
    }).toList();

    return MedicineLiked.fromState(
      state: this,
      medicines: updated,
      medicineId: medicineId,
      likedOrUnliked: isLiked,
    );
  }

  MedicineProductsScroll toScroll({
    required double offset,
    required bool displayFilters,
  }) =>
      MedicineProductsScroll.fromState(
        state: this,
        lastOffset: offset,
        displayFilters: displayFilters,
      );

  MedicineSearchFilterChanged toSearchFilterChanged({
    SearchMedicineFilters? searchFilter,
    Timer? debounce,
    MedicalFilters? params,
  }) =>
      MedicineSearchFilterChanged.fromState(
        state: this,
        params: params,
        debounce: debounce,
        selectedMedicineSearchFilter: searchFilter,
      );

  MedicinesLoadLimitReached toLoadLimitReached() => MedicinesLoadLimitReached.fromState(this);

  MedicineProductsLoaded toLoaded({
    required List<BaseMedicineCatalogModel> medicines,
    required int totalItemsCount,
  }) =>
      MedicineProductsLoaded.fromState(
        state: this,
        medicines: medicines,
        totalItemsCount: totalItemsCount,
      );

  MedicineProductsLoadingFailed toLoadingFailed() => MedicineProductsLoadingFailed.fromState(this);

  LoadingMoreMedicine toLoadingMore(int offSet) => LoadingMoreMedicine.fromState(offSet, this);
}

final class MedicineProductsInitial extends MedicineProductsState {
  MedicineProductsInitial({
    required super.searchController,
    super.lastOffset = 0.0,
    super.debounce,
    ScrollController? scrollController,
    super.totalItemsCount = 0,
    super.offSet = 0,
    super.medicines = const [],
    super.displayFilters = true,
    super.params = const MedicalFilters(),
    super.selectedMedicineSearchFilter = SearchMedicineFilters.dci,
  }) : super(scrollController: scrollController ?? ScrollController());
}

final class MedicineProductsLoading extends MedicineProductsState {
  MedicineProductsLoading.fromState({required MedicineProductsState state, int? offSet})
      : super(
          lastOffset: state.lastOffset,
          debounce: state.debounce,
          totalItemsCount: state.totalItemsCount,
          offSet: offSet ?? state.offSet,
          medicines: state.medicines,
          displayFilters: state.displayFilters,
          params: state.params,
          selectedMedicineSearchFilter: state.selectedMedicineSearchFilter,
          searchController: state.searchController,
          scrollController: state.scrollController,
        );
}

final class LoadingMoreMedicine extends MedicineProductsState {
  LoadingMoreMedicine.fromState(int offSet, MedicineProductsState state)
      : super(
          lastOffset: state.lastOffset,
          debounce: state.debounce,
          totalItemsCount: state.totalItemsCount,
          offSet: offSet,
          medicines: state.medicines,
          displayFilters: state.displayFilters,
          params: state.params,
          selectedMedicineSearchFilter: state.selectedMedicineSearchFilter,
          searchController: state.searchController,
          scrollController: state.scrollController,
        );
}

final class MedicineProductsLoaded extends MedicineProductsState {
  MedicineProductsLoaded.fromState(
      {required MedicineProductsState state, required super.medicines, required super.totalItemsCount})
      : super(
          lastOffset: state.lastOffset,
          debounce: state.debounce,
          offSet: state.offSet,
          displayFilters: state.displayFilters,
          params: state.params,
          selectedMedicineSearchFilter: state.selectedMedicineSearchFilter,
          searchController: state.searchController,
          scrollController: state.scrollController,
        );
}

final class MedicineProductsLoadingFailed extends MedicineProductsState {
  MedicineProductsLoadingFailed.fromState(MedicineProductsState state)
      : super(
          lastOffset: state.lastOffset,
          debounce: state.debounce,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          medicines: state.medicines,
          displayFilters: state.displayFilters,
          params: state.params,
          selectedMedicineSearchFilter: state.selectedMedicineSearchFilter,
          searchController: state.searchController,
          scrollController: state.scrollController,
        );
}

final class MedicinesLoadLimitReached extends MedicineProductsState {
  MedicinesLoadLimitReached.fromState(MedicineProductsState state)
      : super(
          lastOffset: state.lastOffset,
          debounce: state.debounce,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          medicines: state.medicines,
          displayFilters: state.displayFilters,
          params: state.params,
          selectedMedicineSearchFilter: state.selectedMedicineSearchFilter,
          searchController: state.searchController,
          scrollController: state.scrollController,
        );
}

final class MedicineSearchFilterChanged extends MedicineProductsState {
  MedicineSearchFilterChanged.fromState({
    required MedicineProductsState state,
    SearchMedicineFilters? selectedMedicineSearchFilter,
    Timer? debounce,
    MedicalFilters? params,
  }) : super(
          lastOffset: state.lastOffset,
          debounce: state.debounce,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          medicines: state.medicines,
          displayFilters: state.displayFilters,
          params: state.params,
          selectedMedicineSearchFilter: selectedMedicineSearchFilter ?? state.selectedMedicineSearchFilter,
          searchController: state.searchController,
          scrollController: state.scrollController,
        );
}

final class MedicineProductsScroll extends MedicineProductsState {
  MedicineProductsScroll.fromState({
    required MedicineProductsState state,
    required super.lastOffset,
    required super.displayFilters,
  }) : super(
          debounce: state.debounce,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          medicines: state.medicines,
          params: state.params,
          selectedMedicineSearchFilter: state.selectedMedicineSearchFilter,
          searchController: state.searchController,
          scrollController: state.scrollController,
        );
}

final class MedicineLiked extends MedicineProductsState {
  final String medicineId;
  final bool likedOrUnliked;

  MedicineLiked.fromState({
    required MedicineProductsState state,
    required super.medicines,
    required this.medicineId,
    required this.likedOrUnliked,
  }) : super(
          lastOffset: state.lastOffset,
          debounce: state.debounce,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          displayFilters: state.displayFilters,
          params: state.params,
          selectedMedicineSearchFilter: state.selectedMedicineSearchFilter,
          searchController: state.searchController,
          scrollController: state.scrollController,
        );
}

final class MedicineLikeFailed extends MedicineProductsState {
  final String medicineId;

  MedicineLikeFailed.fromState(
    MedicineProductsState state, {
    required this.medicineId,
  }) : super(
          lastOffset: state.lastOffset,
          debounce: state.debounce,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          medicines: state.medicines,
          displayFilters: state.displayFilters,
          params: state.params,
          selectedMedicineSearchFilter: state.selectedMedicineSearchFilter,
          searchController: state.searchController,
          scrollController: state.scrollController,
        );
}
