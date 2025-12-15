part of 'para_pharma_cubit.dart';

sealed class ParaPharmaState {
  final int totalItemsCount;
  final int offSet;

  final List<BaseParaPharmaCatalogModel> paraPharmaProducts;
  ParaPharmFilters filters;
  final double lastOffset;

  final TextEditingController searchController;
  final ScrollController scrollController;

  ParaPharmaState({
    required this.lastOffset,
    required this.searchController,
    required this.scrollController,
    required this.totalItemsCount,
    required this.offSet,
    required this.paraPharmaProducts,
    required this.filters,
  });

  ParaPharmaInitial toInitial({
    double lastOffset = 0.0,
    dynamic debounce,
    int totalItemsCount = 0,
    int offSet = 0,
    List<BaseParaPharmaCatalogModel> paraPharmaProducts = const [],
    bool displayFilters = false,
    ParaPharmFilters filters = const ParaPharmFilters(),
    ParaPharmSearchByFields selectedParaPharmaSearchFilter = ParaPharmSearchByFields.name,
  }) {
    return ParaPharmaInitial(
      lastOffset: lastOffset,
      totalItemsCount: totalItemsCount,
      offSet: offSet,
      paraPharmaProducts: paraPharmaProducts,
      filters: filters,
    );
  }

  ParaPharmaProductsLoading toLoading({int? offset, ParaPharmFilters? filters}) =>
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
      );

  ParaPharmaSearchFilterChanged toSearchFilterChanged({
    Timer? debounce,
    ParaPharmFilters? filters,
  }) =>
      ParaPharmaSearchFilterChanged.fromState(
        state: this,
        filters: filters ?? this.filters,
        debounce: debounce,
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
    super.filters = const ParaPharmFilters(),
  }) : super(
          searchController: searchController ?? TextEditingController(),
          scrollController: scrollController ?? ScrollController(),
        );
}

final class ParaPharmaProductsLoading extends ParaPharmaState {
  ParaPharmaProductsLoading.fromState({required ParaPharmaState state, int? offSet, ParaPharmFilters? filters})
      : super(
          lastOffset: state.lastOffset,
          totalItemsCount: state.totalItemsCount,
          offSet: offSet ?? state.offSet,
          paraPharmaProducts: state.paraPharmaProducts,
          filters: filters ?? state.filters,
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
          filters: state.filters,
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
          filters: state.filters,
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
          filters: state.filters,
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
          filters: state.filters,
          searchController: state.searchController,
          scrollController: state.scrollController,
        );
}

final class ParaPharmaSearchFilterChanged extends ParaPharmaState {
  ParaPharmaSearchFilterChanged.fromState(
      {required ParaPharmaState state,
      required super.filters,
      Timer? debounce,
      ParaPharmSearchByFields? selectedParaPharmaSearchFilter})
      : super(
          lastOffset: state.lastOffset,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          paraPharmaProducts: state.paraPharmaProducts,
          searchController: state.searchController,
          scrollController: state.scrollController,
        );
}

final class ParaPharmaProductsScroll extends ParaPharmaState {
  ParaPharmaProductsScroll.fromState({
    required ParaPharmaState state,
    required super.lastOffset,
    required,
  }) : super(
          offSet: state.offSet,
          totalItemsCount: state.totalItemsCount,
          paraPharmaProducts: state.paraPharmaProducts,
          filters: state.filters,
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
          filters: state.filters,
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
          filters: state.filters,
          searchController: state.searchController,
          scrollController: state.scrollController,
        );
}
