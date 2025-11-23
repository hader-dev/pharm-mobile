part of 'para_pharma_cubit.dart';

sealed class ParaPharmaState {
  final int totalItemsCount;
  final int offSet;
  final SearchParaPharmaFilters selectedParaPharmaSearchFilter;
  final List<BaseParaPharmaCatalogModel> paraPharmaProducts;
  final ParaMedicalFilters filters;
  final double lastOffset;
  final bool displayFilters;
  final TextEditingController searchController;
  final ScrollController scrollController;

  const ParaPharmaState({
    required this.lastOffset,
    required this.searchController,
    required this.scrollController,
    required this.totalItemsCount,
    required this.offSet,
    required this.paraPharmaProducts,
    required this.displayFilters,
    required this.filters,
    required this.selectedParaPharmaSearchFilter,
  });

  bool get hasActiveFilters => filters.isNotEmpty || hasPriceFilters || searchController.text.isNotEmpty;

  bool get hasPriceFilters =>
      (filters.gteUnitPriceHt != null && filters.gteUnitPriceHt != "0.0") ||
      (filters.lteUnitPriceHt != null && filters.lteUnitPriceHt != "100000.0");

  ParaPharmaInitial toInitial({
    double lastOffset = 0.0,
    dynamic debounce,
    int totalItemsCount = 0,
    int offSet = 0,
    List<BaseParaPharmaCatalogModel> paraPharmaProducts = const [],
    bool displayFilters = false,
    ParaMedicalFilters filters = const ParaMedicalFilters(),
    SearchParaPharmaFilters selectedParaPharmaSearchFilter = SearchParaPharmaFilters.name,
  }) {
    return ParaPharmaInitial(
      lastOffset: lastOffset,
      totalItemsCount: totalItemsCount,
      offSet: offSet,
      paraPharmaProducts: paraPharmaProducts,
      displayFilters: displayFilters,
      filters: filters,
      selectedParaPharmaSearchFilter: selectedParaPharmaSearchFilter,
    );
  }

  ParaPharmaProductsLoading toLoading({int? offset, ParaMedicalFilters? filters}) =>
      ParaPharmaProductsLoading.fromState(state: this, offSet: offset, filters: filters);

  ParaPharmaLikeFailed tolikeFailed({required String paraPharmaId}) =>
      ParaPharmaLikeFailed.fromState(state: this, paraPharmaId: paraPharmaId);

  ParaPharmaLiked toLiked({required String paraPharmaId, required bool isLiked}) {
    final updated = paraPharmaProducts.map((element) {
      if (element.id == paraPharmaId) {
        return element.copyWith(isLiked: isLiked);
      }
      return element;
    }).toList();

    return ParaPharmaLiked.fromState(
      state: this,
      paraPharmaProducts: updated,
      paraPharmaId: paraPharmaId,
      likedOrUnliked: isLiked,
    );
  }

  ParaPharmaProductsScroll toScroll({
    required double offset,
    required bool displayFilters,
  }) =>
      ParaPharmaProductsScroll.fromState(
        lastOffset: offset,
        state: this,
        displayFilters: displayFilters,
      );

  ParaPharmaSearchFilterChanged toSearchFilterChanged({
    SearchParaPharmaFilters? searchFilter,
    Timer? debounce,
    ParaMedicalFilters? filters,
  }) =>
      ParaPharmaSearchFilterChanged.fromState(
        state: this,
        filters: filters ?? this.filters,
        debounce: debounce,
        selectedParaPharmaSearchFilter: searchFilter,
      );

  ParaPharmasLoadLimitReached toLoadLimitReached() => ParaPharmasLoadLimitReached.fromState(state: this);

  ParaPharmaProductsLoaded toLoaded({
    required List<BaseParaPharmaCatalogModel> paraPharmaProducts,
    required int totalItemsCount,
  }) =>
      ParaPharmaProductsLoaded.fromState(
        state: this,
        paraPharmaProducts: paraPharmaProducts,
        totalItemsCount: totalItemsCount,
      );

  ParaPharmaProductsLoadingFailed toLoadingFailed() => ParaPharmaProductsLoadingFailed.fromState(state: this);

  LoadingMoreParaPharma toLoadingMore(int offSet) => LoadingMoreParaPharma.fromState(offSet: offSet, state: this);
}

final class ParaPharmaInitial extends ParaPharmaState {
  ParaPharmaInitial({
    super.lastOffset = 0.0,
    TextEditingController? searchController,
    ScrollController? scrollController,
    super.totalItemsCount = 0,
    super.offSet = 0,
    super.paraPharmaProducts = const [],
    super.displayFilters = true,
    super.filters = const ParaMedicalFilters(),
    super.selectedParaPharmaSearchFilter = SearchParaPharmaFilters.name,
  }) : super(
          searchController: searchController ?? TextEditingController(),
          scrollController: scrollController ?? ScrollController(),
        );
}

final class ParaPharmaProductsLoading extends ParaPharmaState {
  ParaPharmaProductsLoading.fromState({required ParaPharmaState state, int? offSet, ParaMedicalFilters? filters})
      : super(
          lastOffset: state.lastOffset,
          totalItemsCount: state.totalItemsCount,
          offSet: offSet ?? state.offSet,
          paraPharmaProducts: state.paraPharmaProducts,
          displayFilters: state.displayFilters,
          filters: filters ?? state.filters,
          selectedParaPharmaSearchFilter: state.selectedParaPharmaSearchFilter,
          searchController: state.searchController,
          scrollController: state.scrollController,
        );
}

final class LoadingMoreParaPharma extends ParaPharmaState {
  LoadingMoreParaPharma.fromState({required super.offSet, required ParaPharmaState state})
      : super(
          lastOffset: state.lastOffset,
          totalItemsCount: state.totalItemsCount,
          paraPharmaProducts: state.paraPharmaProducts,
          displayFilters: state.displayFilters,
          filters: state.filters,
          selectedParaPharmaSearchFilter: state.selectedParaPharmaSearchFilter,
          searchController: state.searchController,
          scrollController: state.scrollController,
        );
}

final class ParaPharmaProductsLoaded extends ParaPharmaState {
  ParaPharmaProductsLoaded.fromState({
    required ParaPharmaState state,
    required super.paraPharmaProducts,
    required super.totalItemsCount,
  }) : super(
          lastOffset: state.lastOffset,
          offSet: state.offSet,
          displayFilters: state.displayFilters,
          filters: state.filters,
          selectedParaPharmaSearchFilter: state.selectedParaPharmaSearchFilter,
          searchController: state.searchController,
          scrollController: state.scrollController,
        );
}

final class ParaPharmaProductsLoadingFailed extends ParaPharmaState {
  ParaPharmaProductsLoadingFailed.fromState({required ParaPharmaState state})
      : super(
          lastOffset: state.lastOffset,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          paraPharmaProducts: state.paraPharmaProducts,
          displayFilters: state.displayFilters,
          filters: state.filters,
          selectedParaPharmaSearchFilter: state.selectedParaPharmaSearchFilter,
          searchController: state.searchController,
          scrollController: state.scrollController,
        );
}

final class ParaPharmasLoadLimitReached extends ParaPharmaState {
  ParaPharmasLoadLimitReached.fromState({required ParaPharmaState state})
      : super(
          lastOffset: state.lastOffset,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          paraPharmaProducts: state.paraPharmaProducts,
          displayFilters: state.displayFilters,
          filters: state.filters,
          selectedParaPharmaSearchFilter: state.selectedParaPharmaSearchFilter,
          searchController: state.searchController,
          scrollController: state.scrollController,
        );
}

final class ParaPharmaSearchFilterChanged extends ParaPharmaState {
  ParaPharmaSearchFilterChanged.fromState(
      {required ParaPharmaState state,
      required super.filters,
      Timer? debounce,
      SearchParaPharmaFilters? selectedParaPharmaSearchFilter})
      : super(
          lastOffset: state.lastOffset,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          paraPharmaProducts: state.paraPharmaProducts,
          displayFilters: state.displayFilters,
          selectedParaPharmaSearchFilter: selectedParaPharmaSearchFilter ?? state.selectedParaPharmaSearchFilter,
          searchController: state.searchController,
          scrollController: state.scrollController,
        );
}

final class ParaPharmaProductsScroll extends ParaPharmaState {
  ParaPharmaProductsScroll.fromState({
    required ParaPharmaState state,
    required super.lastOffset,
    required super.displayFilters,
  }) : super(
          offSet: state.offSet,
          totalItemsCount: state.totalItemsCount,
          paraPharmaProducts: state.paraPharmaProducts,
          filters: state.filters,
          selectedParaPharmaSearchFilter: state.selectedParaPharmaSearchFilter,
          searchController: state.searchController,
          scrollController: state.scrollController,
        );
}

final class ParaPharmaLiked extends ParaPharmaState {
  final String paraPharmaId;
  final bool likedOrUnliked;

  ParaPharmaLiked.fromState({
    required ParaPharmaState state,
    required super.paraPharmaProducts,
    required this.paraPharmaId,
    required this.likedOrUnliked,
  }) : super(
          lastOffset: state.lastOffset,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          displayFilters: state.displayFilters,
          filters: state.filters,
          selectedParaPharmaSearchFilter: state.selectedParaPharmaSearchFilter,
          searchController: state.searchController,
          scrollController: state.scrollController,
        );
}

final class ParaPharmaLikeFailed extends ParaPharmaState {
  final String paraPharmaId;

  ParaPharmaLikeFailed.fromState({
    required ParaPharmaState state,
    required this.paraPharmaId,
  }) : super(
          lastOffset: state.lastOffset,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          paraPharmaProducts: state.paraPharmaProducts,
          displayFilters: state.displayFilters,
          filters: state.filters,
          selectedParaPharmaSearchFilter: state.selectedParaPharmaSearchFilter,
          searchController: state.searchController,
          scrollController: state.scrollController,
        );
}
