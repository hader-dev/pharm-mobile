part of 'medicine_products_cubit.dart';

sealed class MedicineProductsState {
  final int totalItemsCount;
  final int offSet;

  final List<BaseMedicineCatalogModel> medicines;
  final MedicinesFilters filters;
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
    required this.filters,
    required this.searchController,
  });

  MedicineProductsInitial toInitial({
    double lastOffset = 0.0,
    dynamic debounce,
    int totalItemsCount = 0,
    int offSet = 0,
    List<BaseMedicineCatalogModel> medicines = const [],
    bool displayFilters = false,
    ScrollController? scrollController,
    MedicinesFilters filters = const MedicinesFilters(),
    SearchMedicineFilters = SearchMedicinesByFields.dci,
  }) {
    return MedicineProductsInitial(
      lastOffset: lastOffset,
      debounce: debounce,
      searchController: searchController,
      totalItemsCount: totalItemsCount,
      offSet: offSet,
      medicines: medicines,
      displayFilters: displayFilters,
      filters: filters,
      scrollController: scrollController ?? ScrollController(),
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
    Timer? debounce,
    MedicinesFilters? filters,
  }) =>
      MedicineSearchFilterChanged.fromState(
        state: this,
        filters: filters,
        debounce: debounce,
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
    super.filters = const MedicinesFilters(),
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
          filters: state.filters,
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
          filters: state.filters,
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
          filters: state.filters,
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
          filters: state.filters,
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
          filters: state.filters,
          searchController: state.searchController,
          scrollController: state.scrollController,
        );
}

final class MedicineSearchFilterChanged extends MedicineProductsState {
  MedicineSearchFilterChanged.fromState({
    required MedicineProductsState state,
    Timer? debounce,
    MedicinesFilters? filters,
  }) : super(
          lastOffset: state.lastOffset,
          debounce: state.debounce,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          medicines: state.medicines,
          displayFilters: state.displayFilters,
          filters: filters ?? state.filters,
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
          filters: state.filters,
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
          filters: state.filters,
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
          filters: state.filters,
          searchController: state.searchController,
          scrollController: state.scrollController,
        );
}
