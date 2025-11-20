part of 'orders_cubit.dart';

sealed class OrdersState {
  final int totalItemsCount;
  final int offSet;
  final List<BaseOrderModel> orders;
  final bool displayFilters;
  final bool hasActiveFilters;
  final OrderFilters filters;
  final double lastOffset;
  final ScrollController scrollController;

  OrdersState(
      {required this.totalItemsCount,
      required this.offSet,
      this.filters = const OrderFilters(),
      this.displayFilters = true,
      this.hasActiveFilters = false,
      required this.scrollController,
      required this.lastOffset,
      required this.orders});

  OrdersInitial toInitial({
    int totalItemsCount = 0,
    int offSet = 0,
    double lastOffset = 0,
    List<BaseOrderModel> orders = const [],
    OrderFilters filters = const OrderFilters(),
    bool displayFilters = false,
  }) {
    return OrdersInitial(
        totalItemsCount: totalItemsCount,
        offSet: offSet,
        orders: orders,
        lastOffset: lastOffset,
        scrollController: scrollController);
  }

  OrdersScroll toScroll({
    required double offset,
    required bool displayFilters,
  }) =>
      OrdersScroll.fromState(
        lastOffset: offset,
        state: this,
        displayFilters: displayFilters,
      );

  OrdersLoading toLoading({int? offset}) => OrdersLoading.fromState(state: this, offSet: offset ?? offSet);

  OrdersLoadingFilterChanged toSearchFilterChanged({
    required OrderFilters filters,
  }) =>
      OrdersLoadingFilterChanged.fromState(state: this, filters: filters);

  OrdersLoaded toLoaded({
    List<BaseOrderModel>? orders,
    int? totalItemsCount,
  }) =>
      OrdersLoaded.fromState(
        state: this,
        orders: orders ?? this.orders,
        totalItemsCount: totalItemsCount ?? this.totalItemsCount,
      );
  LoadingMoreOrders toLoadingMore(int offSet) => LoadingMoreOrders.fromState(offSet, this);
  OrdersLoadLimitReached toLoadLimitReached() => OrdersLoadLimitReached.fromState(this);
  OrdersLoadingFailed toLoadingFailed() => OrdersLoadingFailed.fromState(
        state: this,
      );
}

final class OrdersInitial extends OrdersState {
  OrdersInitial({
    ScrollController? scrollController,
    super.totalItemsCount = 0,
    super.offSet = 0,
    super.orders = const [],
    super.lastOffset = 0,
  }) : super(
          scrollController: scrollController ?? ScrollController(),
        );
}

final class OrdersLoading extends OrdersState {
  OrdersLoading.fromState({required OrdersState state, required super.offSet})
      : super(
          totalItemsCount: state.totalItemsCount,
          orders: state.orders,
          scrollController: state.scrollController,
          displayFilters: state.displayFilters,
          hasActiveFilters: state.hasActiveFilters,
          filters: state.filters,
          lastOffset: state.lastOffset,
        );
}

final class OrdersLoadingFilterChanged extends OrdersState {
  OrdersLoadingFilterChanged.fromState({required OrdersState state, required super.filters})
      : super(
          totalItemsCount: state.totalItemsCount,
          orders: state.orders,
          offSet: state.offSet,
          scrollController: state.scrollController,
          displayFilters: state.displayFilters,
          hasActiveFilters: state.hasActiveFilters,
          lastOffset: state.lastOffset,
        );
}

final class LoadingMoreOrders extends OrdersState {
  LoadingMoreOrders.fromState(int offSet, OrdersState state)
      : super(
          totalItemsCount: state.totalItemsCount,
          offSet: offSet,
          scrollController: state.scrollController,
          orders: state.orders,
          displayFilters: state.displayFilters,
          hasActiveFilters: state.hasActiveFilters,
          filters: state.filters,
          lastOffset: state.lastOffset,
        );
}

final class OrdersLoaded extends OrdersState {
  OrdersLoaded.fromState({required OrdersState state, required super.orders, required super.totalItemsCount})
      : super(
          offSet: state.offSet,
          scrollController: state.scrollController,
          displayFilters: state.displayFilters,
          hasActiveFilters: state.hasActiveFilters,
          filters: state.filters,
          lastOffset: state.lastOffset,
        );
}

final class OrdersLoadingFailed extends OrdersState {
  OrdersLoadingFailed.fromState({
    required OrdersState state,
  }) : super(
          totalItemsCount: state.totalItemsCount,
          scrollController: state.scrollController,
          offSet: state.offSet,
          orders: state.orders,
          lastOffset: state.lastOffset,
        );
}

final class OrdersLoadLimitReached extends OrdersState {
  OrdersLoadLimitReached.fromState(OrdersState state)
      : super(
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          orders: state.orders,
          scrollController: state.scrollController,
          displayFilters: state.displayFilters,
          hasActiveFilters: state.hasActiveFilters,
          filters: state.filters,
          lastOffset: state.lastOffset,
        );
}

final class OrdersScroll extends OrdersState {
  OrdersScroll.fromState({
    required OrdersState state,
    required super.lastOffset,
    required super.displayFilters,
  }) : super(
          offSet: state.offSet,
          scrollController: state.scrollController,
          totalItemsCount: state.totalItemsCount,
          filters: state.filters,
          orders: state.orders,
          hasActiveFilters: state.hasActiveFilters,
        );
}
