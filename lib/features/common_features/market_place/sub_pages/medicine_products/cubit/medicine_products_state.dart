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

  const MedicineProductsState({
    required this.lastOffset,
    required this.debounce,
    required this.totalItemsCount,
    required this.offSet,
    required this.medicines,
    required this.displayFilters,
    required this.params,
    required this.selectedMedicineSearchFilter,
  });

  MedicineProductsState copyWith({
    double? lastOffset,
    Timer? debounce,
    int? totalItemsCount,
    int? offSet,
    List<BaseMedicineCatalogModel>? medicines,
    bool? displayFilters,
    MedicalFilters? params,
    SearchMedicineFilters? selectedMedicineSearchFilter,
  }) {
    return MedicineProductsInitial(
      lastOffset: lastOffset ?? this.lastOffset,
      debounce: debounce ?? this.debounce,
      totalItemsCount: totalItemsCount ?? this.totalItemsCount,
      offSet: offSet ?? this.offSet,
      medicines: medicines ?? this.medicines,
      displayFilters: displayFilters ?? this.displayFilters,
      params: params ?? this.params,
      selectedMedicineSearchFilter:
          selectedMedicineSearchFilter ?? this.selectedMedicineSearchFilter,
    );
  }

  MedicineProductsInitial initial({
    double lastOffset = 0.0,
    dynamic debounce,
    int totalItemsCount = 0,
    int offSet = 0,
    List<BaseMedicineCatalogModel> medicines = const [],
    bool displayFilters = false,
    MedicalFilters params = const MedicalFilters(),
    SearchMedicineFilters selectedMedicineSearchFilter =
        SearchMedicineFilters.dci,
  }) {
    return MedicineProductsInitial(
      lastOffset: lastOffset,
      debounce: debounce,
      totalItemsCount: totalItemsCount,
      offSet: offSet,
      medicines: medicines,
      displayFilters: displayFilters,
      params: params,
      selectedMedicineSearchFilter: selectedMedicineSearchFilter,
    );
  }

  MedicineProductsLoading loading({int? offset}) =>
      MedicineProductsLoading.fromState(
        copyWith(offSet: offset ?? offSet),
      );

  MedicineLikeFailed likeFailed({required String medicineId}) =>
      MedicineLikeFailed.fromState(this, medicineId: medicineId);

  MedicineLiked liked({required String medicineId, required bool isLiked}) {
    final updated = medicines.map((element) {
      if (element.id == medicineId) {
        element.isLiked = isLiked;
        return element;
      }
      return element;
    }).toList();

    return MedicineLiked.fromState(
      copyWith(medicines: updated),
      medicineId: medicineId,
      likedOrUnliked: isLiked,
    );
  }

  MedicineProductsScroll scroll({
    required double offset,
    required bool displayFilters,
  }) =>
      MedicineProductsScroll.fromState(
        copyWith(
          lastOffset: offset,
          displayFilters: displayFilters,
        ),
      );

  MedicineSearchFilterChanged searchFilterChanged({
    SearchMedicineFilters? searchFilter,
    Timer? debounce,
    MedicalFilters? params,
  }) =>
      MedicineSearchFilterChanged.fromState(
        copyWith(
          params: params ?? params,
          debounce: debounce ?? debounce,
          selectedMedicineSearchFilter:
              searchFilter ?? selectedMedicineSearchFilter,
        ),
      );

  MedicinesLoadLimitReached loadLimitReached() =>
      MedicinesLoadLimitReached.fromState(this);

  MedicineProductsLoaded loaded({
    List<BaseMedicineCatalogModel>? medicines,
    int? totalItemsCount,
  }) =>
      MedicineProductsLoaded.fromState(
        copyWith(
          medicines: medicines ?? medicines,
          totalItemsCount: totalItemsCount ?? totalItemsCount,
        ),
      );

  MedicineProductsLoadingFailed loadingFailed() =>
      MedicineProductsLoadingFailed.fromState(this);

  LoadingMoreMedicine loadingMore() => LoadingMoreMedicine.fromState(this);
}

final class MedicineProductsInitial extends MedicineProductsState {
  MedicineProductsInitial({
    super.lastOffset = 0.0,
    super.debounce,
    super.totalItemsCount = 0,
    super.offSet = 0,
    super.medicines = const [],
    super.displayFilters = true,
    super.params = const MedicalFilters(),
    super.selectedMedicineSearchFilter = SearchMedicineFilters.dci,
  });
}

final class MedicineProductsLoading extends MedicineProductsState {
  MedicineProductsLoading.fromState(MedicineProductsState state)
      : super(
          lastOffset: state.lastOffset,
          debounce: state.debounce,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          medicines: state.medicines,
          displayFilters: state.displayFilters,
          params: state.params,
          selectedMedicineSearchFilter: state.selectedMedicineSearchFilter,
        );
}

final class LoadingMoreMedicine extends MedicineProductsState {
  LoadingMoreMedicine.fromState(MedicineProductsState state)
      : super(
          lastOffset: state.lastOffset,
          debounce: state.debounce,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          medicines: state.medicines,
          displayFilters: state.displayFilters,
          params: state.params,
          selectedMedicineSearchFilter: state.selectedMedicineSearchFilter,
        );
}

final class MedicineProductsLoaded extends MedicineProductsState {
  MedicineProductsLoaded.fromState(MedicineProductsState state)
      : super(
          lastOffset: state.lastOffset,
          debounce: state.debounce,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          medicines: state.medicines,
          displayFilters: state.displayFilters,
          params: state.params,
          selectedMedicineSearchFilter: state.selectedMedicineSearchFilter,
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
        );
}

final class MedicineSearchFilterChanged extends MedicineProductsState {
  MedicineSearchFilterChanged.fromState(MedicineProductsState state)
      : super(
          lastOffset: state.lastOffset,
          debounce: state.debounce,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          medicines: state.medicines,
          displayFilters: state.displayFilters,
          params: state.params,
          selectedMedicineSearchFilter: state.selectedMedicineSearchFilter,
        );
}

final class MedicineProductsScroll extends MedicineProductsState {
  MedicineProductsScroll.fromState(MedicineProductsState state)
      : super(
          lastOffset: state.lastOffset,
          debounce: state.debounce,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          medicines: state.medicines,
          displayFilters: state.displayFilters,
          params: state.params,
          selectedMedicineSearchFilter: state.selectedMedicineSearchFilter,
        );
}

final class MedicineLiked extends MedicineProductsState {
  final String medicineId;
  final bool likedOrUnliked;

  MedicineLiked.fromState(
    MedicineProductsState state, {
    required this.medicineId,
    required this.likedOrUnliked,
  }) : super(
          lastOffset: state.lastOffset,
          debounce: state.debounce,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          medicines: state.medicines,
          displayFilters: state.displayFilters,
          params: state.params,
          selectedMedicineSearchFilter: state.selectedMedicineSearchFilter,
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
        );
}
