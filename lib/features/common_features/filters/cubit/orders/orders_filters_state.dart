part of 'orders_filters_cubit.dart';

sealed class OrdersFiltersState {
  final int pageIndex;
  final OrderFilters filtersSource;
  final OrderFilters appliedFilters;
  final OrderFiltersKeys currentKey;
  final Timer? searchDebounceTimer;

  const OrdersFiltersState({
    this.pageIndex = 0,
    this.filtersSource = const OrderFilters(),
    this.appliedFilters = const OrderFilters(),
    this.currentKey = OrderFiltersKeys.status,
    this.searchDebounceTimer,
  });

  OrdersFiltersState copyWith({
    int? pageIndex,
    OrderFilters? filtersSource,
    OrderFilters? appliedFilters,
    OrderFiltersKeys? currentKey,
    Timer? searchDebounceTimer,
  }) {
    return OrderFiltersStateInitial(
      pageIndex: pageIndex ?? this.pageIndex,
      filtersSource: filtersSource ?? this.filtersSource,
      appliedFilters: appliedFilters ?? this.appliedFilters,
      currentKey: currentKey ?? this.currentKey,
      searchDebounceTimer: searchDebounceTimer ?? this.searchDebounceTimer,
    );
  }

  OrderFiltersStateInitial initial({
    int pageIndex = 0,
    OrderFilters filtersSource = const OrderFilters(),
    OrderFilters appliedFilters = const OrderFilters(),
    OrderFiltersKeys currentKey = OrderFiltersKeys.status,
    Timer? searchDebounceTimer,
  }) {
    return OrderFiltersStateInitial(
      pageIndex: pageIndex,
      filtersSource: filtersSource,
      appliedFilters: appliedFilters,
      currentKey: currentKey,
      searchDebounceTimer: searchDebounceTimer,
    );
  }

  OrderFiltersIsLoading loading() => OrderFiltersIsLoading(
        pageIndex: pageIndex,
        filtersSource: filtersSource,
        appliedFilters: appliedFilters,
        currentKey: currentKey,
        searchDebounceTimer: searchDebounceTimer,
      );

  OrderFiltersLoaded loaded({
    OrderFilters? updatedFiltersSource,
  }) =>
      OrderFiltersLoaded(
        pageIndex: pageIndex,
        filtersSource: updatedFiltersSource ?? filtersSource,
        appliedFilters: appliedFilters,
        currentKey: currentKey,
        searchDebounceTimer: searchDebounceTimer,
      );

  OrderFiltersLoadingError loadingError() => OrderFiltersLoadingError(
        pageIndex: pageIndex,
        filtersSource: filtersSource,
        appliedFilters: appliedFilters,
        currentKey: currentKey,
        searchDebounceTimer: searchDebounceTimer,
      );

  OrderFiltersPageChanged pageChanged({int? newPageIndex}) =>
      OrderFiltersPageChanged(
        pageIndex: newPageIndex ?? pageIndex,
        filtersSource: filtersSource,
        appliedFilters: appliedFilters,
        currentKey: currentKey,
        searchDebounceTimer: searchDebounceTimer,
      );

  OrderFiltersUpdated updated({
    OrderFilters? updatedAppliedFilters,
    OrderFilters? updatedFiltersSource,
    OrderFiltersKeys? updatedCurrentKey,
  }) =>
      OrderFiltersUpdated(
        pageIndex: pageIndex,
        filtersSource: updatedFiltersSource ?? filtersSource,
        appliedFilters: updatedAppliedFilters ?? appliedFilters,
        currentKey: updatedCurrentKey ?? currentKey,
        searchDebounceTimer: searchDebounceTimer,
      );
}

final class OrderFiltersStateInitial extends OrdersFiltersState {
  const OrderFiltersStateInitial({
    super.pageIndex,
    super.filtersSource,
    super.appliedFilters,
    super.currentKey,
    super.searchDebounceTimer,
  });
}

final class OrderFiltersIsLoading extends OrdersFiltersState {
  const OrderFiltersIsLoading({
    super.pageIndex,
    super.filtersSource,
    super.appliedFilters,
    super.currentKey,
    super.searchDebounceTimer,
  });
}

final class OrderFiltersLoaded extends OrdersFiltersState {
  const OrderFiltersLoaded({
    super.pageIndex,
    super.filtersSource,
    super.appliedFilters,
    super.currentKey,
    super.searchDebounceTimer,
  });
}

final class OrderFiltersLoadingError extends OrdersFiltersState {
  const OrderFiltersLoadingError({
    super.pageIndex,
    super.filtersSource,
    super.appliedFilters,
    super.currentKey,
    super.searchDebounceTimer,
  });
}

final class OrderFiltersPageChanged extends OrdersFiltersState {
  const OrderFiltersPageChanged({
    super.pageIndex,
    super.filtersSource,
    super.appliedFilters,
    super.currentKey,
    super.searchDebounceTimer,
  });
}

final class OrderFiltersUpdated extends OrdersFiltersState {
  const OrderFiltersUpdated({
    super.pageIndex,
    super.filtersSource,
    super.appliedFilters,
    super.currentKey,
    super.searchDebounceTimer,
  });
}
