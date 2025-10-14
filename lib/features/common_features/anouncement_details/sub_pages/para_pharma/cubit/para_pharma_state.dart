part of 'para_pharma_cubit.dart';

sealed class ParaPharmaState {
  final int totalItemsCount;
  final int offSet;
  final SearchParaPharmaFilters? selectedParaPharmaSearchFilter;
  final List<BaseParaPharmaCatalogModel> paraPharmaProducts;
  final ParaMedicalFilters filters;

  final TextEditingController searchController;
  final ScrollController scrollController;

  ParaPharmaState(
      {required this.totalItemsCount,
      required this.offSet,
      required this.selectedParaPharmaSearchFilter,
      required this.paraPharmaProducts,
      required this.filters,
      required this.searchController,
      required this.scrollController});

  bool get hasActiveFilters =>
      filters.isNotEmpty ||
      filters.gteUnitPriceHt != null ||
      filters.lteUnitPriceHt != null;

  ParaPharmaProductsLoading toLoading() =>
      ParaPharmaProductsLoading.fromState(state: this);

  ParaPharmaProductsLoadingFailed toLoadingFailed() =>
      ParaPharmaProductsLoadingFailed.fromState(state: this);

  ParaPharmaProductsLoaded toLoaded({
    required List<BaseParaPharmaCatalogModel> paraPharmaProducts,
    required int totalItemsCount,
  }) =>
      ParaPharmaProductsLoaded.fromState(
          state: this,
          paraPharmaProducts: paraPharmaProducts,
          totalItemsCount: totalItemsCount);

  ParaPharmasLoadLimitReached toLoadLimitReached() =>
      ParaPharmasLoadLimitReached.fromState(state: this);

  ParaPharmaSearchFilterChanged toSearchFilterChanged({
    required SearchParaPharmaFilters? selectedParaPharmaSearchFilter,
    ParaMedicalFilters? filters,
  }) =>
      ParaPharmaSearchFilterChanged.fromState(
          state: this,
          selectedParaPharmaSearchFilter: selectedParaPharmaSearchFilter,
          filters: filters ?? this.filters);

  ParaPharmaLikeFailed tolikeFailed({required String paraPharmaId}) =>
      ParaPharmaLikeFailed.fromState(state: this, paraPharmaId: paraPharmaId);

  ParaPharmaLiked toLiked({required String paraPharmaId, required bool liked}) {
    final updatedItems = paraPharmaProducts.map((el) {
      if (el.id == paraPharmaId) {
        return el.copyWith(isLiked: liked);
      }
      return el;
    }).toList();

    return ParaPharmaLiked.fromState(
      state: this,
      paraPharmaProducts: updatedItems,
    );
  }
}

final class ParaPharmaInitial extends ParaPharmaState {
  ParaPharmaInitial({
    int? totalItemsCount,
    int? offSet,
    super.selectedParaPharmaSearchFilter,
    List<BaseParaPharmaCatalogModel>? paraPharmaProducts,
    ParaMedicalFilters? filters,
    TextEditingController? searchController,
    ScrollController? scrollController,
  }) : super(
          totalItemsCount: totalItemsCount ?? 0,
          offSet: offSet ?? 0,
          paraPharmaProducts: paraPharmaProducts ?? [],
          filters: filters ?? const ParaMedicalFilters(),
          searchController: searchController ?? TextEditingController(),
          scrollController: scrollController ?? ScrollController(),
        );
}

final class ParaPharmaProductsLoading extends ParaPharmaState {
  ParaPharmaProductsLoading.fromState({required ParaPharmaState state})
      : super(
            totalItemsCount: state.totalItemsCount,
            offSet: state.offSet,
            selectedParaPharmaSearchFilter:
                state.selectedParaPharmaSearchFilter,
            paraPharmaProducts: state.paraPharmaProducts,
            filters: state.filters,
            searchController: state.searchController,
            scrollController: state.scrollController);
}

final class LoadingMoreParaPharma extends ParaPharmaState {
  LoadingMoreParaPharma.fromState({required ParaPharmaState state})
      : super(
            totalItemsCount: state.totalItemsCount,
            offSet: state.offSet,
            selectedParaPharmaSearchFilter:
                state.selectedParaPharmaSearchFilter,
            paraPharmaProducts: state.paraPharmaProducts,
            filters: state.filters,
            searchController: state.searchController,
            scrollController: state.scrollController);
}

final class ParaPharmaProductsLoaded extends ParaPharmaState {
  ParaPharmaProductsLoaded.fromState(
      {required ParaPharmaState state,
      required super.paraPharmaProducts,
      required super.totalItemsCount})
      : super(
            offSet: state.offSet,
            selectedParaPharmaSearchFilter:
                state.selectedParaPharmaSearchFilter,
            filters: state.filters,
            searchController: state.searchController,
            scrollController: state.scrollController);
}

final class ParaPharmaProductsLoadingFailed extends ParaPharmaState {
  ParaPharmaProductsLoadingFailed.fromState({required ParaPharmaState state})
      : super(
            totalItemsCount: state.totalItemsCount,
            offSet: state.offSet,
            selectedParaPharmaSearchFilter:
                state.selectedParaPharmaSearchFilter,
            paraPharmaProducts: state.paraPharmaProducts,
            filters: state.filters,
            searchController: state.searchController,
            scrollController: state.scrollController);
}

final class ParaPharmasLoadLimitReached extends ParaPharmaState {
  ParaPharmasLoadLimitReached.fromState({required ParaPharmaState state})
      : super(
            totalItemsCount: state.totalItemsCount,
            offSet: state.offSet,
            selectedParaPharmaSearchFilter:
                state.selectedParaPharmaSearchFilter,
            paraPharmaProducts: state.paraPharmaProducts,
            filters: state.filters,
            searchController: state.searchController,
            scrollController: state.scrollController);
}

final class ParaPharmaSearchFilterChanged extends ParaPharmaState {
  ParaPharmaSearchFilterChanged.fromState({
    required ParaPharmaState state,
    required super.selectedParaPharmaSearchFilter,
    required super.filters,
  }) : super(
            totalItemsCount: state.totalItemsCount,
            offSet: state.offSet,
            paraPharmaProducts: state.paraPharmaProducts,
            searchController: state.searchController,
            scrollController: state.scrollController);
}

final class ParaPharmaLiked extends ParaPharmaState {
  ParaPharmaLiked.fromState(
      {required ParaPharmaState state, required super.paraPharmaProducts})
      : super(
            totalItemsCount: state.totalItemsCount,
            offSet: state.offSet,
            selectedParaPharmaSearchFilter:
                state.selectedParaPharmaSearchFilter,
            filters: state.filters,
            searchController: state.searchController,
            scrollController: state.scrollController);
}

final class ParaPharmaLikeFailed extends ParaPharmaState {
  String paraPharmaId;

  ParaPharmaLikeFailed.fromState(
      {required ParaPharmaState state, required this.paraPharmaId})
      : super(
            totalItemsCount: state.totalItemsCount,
            offSet: state.offSet,
            selectedParaPharmaSearchFilter:
                state.selectedParaPharmaSearchFilter,
            paraPharmaProducts: state.paraPharmaProducts,
            filters: state.filters,
            searchController: state.searchController,
            scrollController: state.scrollController);
}
