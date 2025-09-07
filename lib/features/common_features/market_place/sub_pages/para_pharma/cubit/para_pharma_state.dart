part of 'para_pharma_cubit.dart';

sealed class ParaPharmaState {
  final int totalItemsCount;
  final int offSet;
  final SearchParaPharmaFilters selectedParaPharmaSearchFilter;
  final List<BaseParaPharmaCatalogModel> paraPharmaProducts;
  final ParaMedicalFilters filters;
  final Timer? debounce;
  final double lastOffset;
  final bool displayFilters;

  const ParaPharmaState({
    required this.lastOffset,
    required this.debounce,
    required this.totalItemsCount,
    required this.offSet,
    required this.paraPharmaProducts,
    required this.displayFilters,
    required this.filters,
    required this.selectedParaPharmaSearchFilter,
  });

  ParaPharmaState copyWith({
    double? lastOffset,
    Timer? debounce,
    int? totalItemsCount,
    int? offSet,
    List<BaseParaPharmaCatalogModel>? paraPharmaProducts,
    bool? displayFilters,
    ParaMedicalFilters? filters,
    SearchParaPharmaFilters? selectedParaPharmaSearchFilter,
  }) {
    return ParaPharmaInitial(
      lastOffset: lastOffset ?? this.lastOffset,
      debounce: debounce ?? this.debounce,
      totalItemsCount: totalItemsCount ?? this.totalItemsCount,
      offSet: offSet ?? this.offSet,
      paraPharmaProducts: paraPharmaProducts ?? this.paraPharmaProducts,
      displayFilters: displayFilters ?? this.displayFilters,
      filters: filters ?? this.filters,
      selectedParaPharmaSearchFilter:
          selectedParaPharmaSearchFilter ?? this.selectedParaPharmaSearchFilter,
    );
  }

  ParaPharmaInitial initial({
    double lastOffset = 0.0,
    dynamic debounce,
    int totalItemsCount = 0,
    int offSet = 0,
    List<BaseParaPharmaCatalogModel> paraPharmaProducts = const [],
    bool displayFilters = false,
    ParaMedicalFilters filters = const ParaMedicalFilters(),
    SearchParaPharmaFilters selectedParaPharmaSearchFilter =
        SearchParaPharmaFilters.name,
  }) {
    return ParaPharmaInitial(
      lastOffset: lastOffset,
      debounce: debounce,
      totalItemsCount: totalItemsCount,
      offSet: offSet,
      paraPharmaProducts: paraPharmaProducts,
      displayFilters: displayFilters,
      filters: filters,
      selectedParaPharmaSearchFilter: selectedParaPharmaSearchFilter,
    );
  }

  ParaPharmaProductsLoading loading({int? offset}) =>
      ParaPharmaProductsLoading.fromState(
        copyWith(offSet: offset ?? offSet),
      );

  ParaPharmaLikeFailed likeFailed({required String paraPharmaId}) =>
      ParaPharmaLikeFailed.fromState(this, paraPharmaId: paraPharmaId);

  ParaPharmaLiked liked({required String paraPharmaId, required bool isLiked}) {
    final updated = paraPharmaProducts.map((element) {
      if (element.id == paraPharmaId) {
        return element.copyWith(isLiked: isLiked); // ✅ actually toggle
      }
      return element;
    }).toList();

    return ParaPharmaLiked.fromState(
      copyWith(paraPharmaProducts: updated),
      paraPharmaId: paraPharmaId,
      likedOrUnliked: isLiked,
    );
  }

  ParaPharmaProductsScroll scroll({
    required double offset,
    required bool displayFilters,
  }) =>
      ParaPharmaProductsScroll.fromState(
        copyWith(
          lastOffset: offset,
          displayFilters: displayFilters,
        ),
      );

  ParaPharmaSearchFilterChanged searchFilterChanged({
    SearchParaPharmaFilters? searchFilter,
    Timer? debounce,
    ParaMedicalFilters? filters,
  }) =>
      ParaPharmaSearchFilterChanged.fromState(
        copyWith(
          filters: filters ?? filters,
          debounce: debounce ?? debounce,
          selectedParaPharmaSearchFilter:
              searchFilter ?? selectedParaPharmaSearchFilter,
        ),
      );

  ParaPharmasLoadLimitReached loadLimitReached() =>
      ParaPharmasLoadLimitReached.fromState(this);

  ParaPharmaProductsLoaded loaded({
    List<BaseParaPharmaCatalogModel>? paraPharmaProducts,
    int? totalItemsCount,
  }) =>
      ParaPharmaProductsLoaded.fromState(
        copyWith(
          paraPharmaProducts: paraPharmaProducts ?? paraPharmaProducts,
          totalItemsCount: totalItemsCount ?? totalItemsCount,
        ),
      );

  ParaPharmaProductsLoadingFailed loadingFailed() =>
      ParaPharmaProductsLoadingFailed.fromState(this);

  LoadingMoreParaPharma loadingMore() => LoadingMoreParaPharma.fromState(this);
}

final class ParaPharmaInitial extends ParaPharmaState {
  ParaPharmaInitial({
    super.lastOffset = 0.0,
    super.debounce,
    super.totalItemsCount = 0,
    super.offSet = 0,
    super.paraPharmaProducts = const [],
    super.displayFilters = true,
    super.filters = const ParaMedicalFilters(),
    super.selectedParaPharmaSearchFilter = SearchParaPharmaFilters.name,
  });
}

final class ParaPharmaProductsLoading extends ParaPharmaState {
  ParaPharmaProductsLoading.fromState(ParaPharmaState state)
      : super(
          lastOffset: state.lastOffset,
          debounce: state.debounce,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          paraPharmaProducts: state.paraPharmaProducts,
          displayFilters: state.displayFilters,
          filters: state.filters,
          selectedParaPharmaSearchFilter: state.selectedParaPharmaSearchFilter,
        );
}

final class LoadingMoreParaPharma extends ParaPharmaState {
  LoadingMoreParaPharma.fromState(ParaPharmaState state)
      : super(
          lastOffset: state.lastOffset,
          debounce: state.debounce,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          paraPharmaProducts: state.paraPharmaProducts,
          displayFilters: state.displayFilters,
          filters: state.filters,
          selectedParaPharmaSearchFilter: state.selectedParaPharmaSearchFilter,
        );
}

final class ParaPharmaProductsLoaded extends ParaPharmaState {
  ParaPharmaProductsLoaded.fromState(ParaPharmaState state)
      : super(
          lastOffset: state.lastOffset,
          debounce: state.debounce,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          paraPharmaProducts: state.paraPharmaProducts,
          displayFilters: state.displayFilters,
          filters: state.filters,
          selectedParaPharmaSearchFilter: state.selectedParaPharmaSearchFilter,
        );
}

final class ParaPharmaProductsLoadingFailed extends ParaPharmaState {
  ParaPharmaProductsLoadingFailed.fromState(ParaPharmaState state)
      : super(
          lastOffset: state.lastOffset,
          debounce: state.debounce,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          paraPharmaProducts: state.paraPharmaProducts,
          displayFilters: state.displayFilters,
          filters: state.filters,
          selectedParaPharmaSearchFilter: state.selectedParaPharmaSearchFilter,
        );
}

final class ParaPharmasLoadLimitReached extends ParaPharmaState {
  ParaPharmasLoadLimitReached.fromState(ParaPharmaState state)
      : super(
          lastOffset: state.lastOffset,
          debounce: state.debounce,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          paraPharmaProducts: state.paraPharmaProducts,
          displayFilters: state.displayFilters,
          filters: state.filters,
          selectedParaPharmaSearchFilter: state.selectedParaPharmaSearchFilter,
        );
}

final class ParaPharmaSearchFilterChanged extends ParaPharmaState {
  ParaPharmaSearchFilterChanged.fromState(ParaPharmaState state)
      : super(
          lastOffset: state.lastOffset,
          debounce: state.debounce,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          paraPharmaProducts: state.paraPharmaProducts,
          displayFilters: state.displayFilters,
          filters: state.filters,
          selectedParaPharmaSearchFilter: state.selectedParaPharmaSearchFilter,
        );
}

final class ParaPharmaProductsScroll extends ParaPharmaState {
  ParaPharmaProductsScroll.fromState(ParaPharmaState state)
      : super(
          lastOffset: state.lastOffset,
          debounce: state.debounce,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          paraPharmaProducts: state.paraPharmaProducts,
          displayFilters: state.displayFilters,
          filters: state.filters,
          selectedParaPharmaSearchFilter: state.selectedParaPharmaSearchFilter,
        );
}

final class ParaPharmaLiked extends ParaPharmaState {
  final String paraPharmaId;
  final bool likedOrUnliked;

  ParaPharmaLiked.fromState(
    ParaPharmaState state, {
    required this.paraPharmaId,
    required this.likedOrUnliked,
  }) : super(
          lastOffset: state.lastOffset,
          debounce: state.debounce,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          paraPharmaProducts: state.paraPharmaProducts,
          displayFilters: state.displayFilters,
          filters: state.filters,
          selectedParaPharmaSearchFilter: state.selectedParaPharmaSearchFilter,
        );
}

final class ParaPharmaLikeFailed extends ParaPharmaState {
  final String paraPharmaId;

  ParaPharmaLikeFailed.fromState(
    ParaPharmaState state, {
    required this.paraPharmaId,
  }) : super(
          lastOffset: state.lastOffset,
          debounce: state.debounce,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          paraPharmaProducts: state.paraPharmaProducts,
          displayFilters: state.displayFilters,
          filters: state.filters,
          selectedParaPharmaSearchFilter: state.selectedParaPharmaSearchFilter,
        );
}
