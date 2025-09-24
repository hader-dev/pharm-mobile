part of 'orders_cubit.dart';

sealed class OrdersState {
  final int totalItemsCount;
  final int offSet;
  final List<BaseOrderModel> orders;

  OrdersState(
      {required this.totalItemsCount,
      required this.offSet,
      required this.orders});

  OrdersState copyWith({
    int? totalItemsCount,
    int? offSet,
    List<BaseOrderModel>? orders,
  }) {
    return OrdersInitial(
      totalItemsCount: totalItemsCount ?? this.totalItemsCount,
      offSet: offSet ?? this.offSet,
      orders: orders ?? this.orders,
    );
  }

  OrdersInitial initial({
    int totalItemsCount = 0,
    int offSet = 0,
    List<BaseOrderModel> orders = const [],
  }) {
    return OrdersInitial(
      totalItemsCount: totalItemsCount,
      offSet: offSet,
      orders: orders,
    );
  }

  OrdersLoading loading({int? offset}) =>
      OrdersLoading.fromState(copyWith(offSet: offset ?? offSet));

  OrdersLoaded loaded({
    List<BaseOrderModel>? orders,
    int? totalItemsCount,
  }) =>
      OrdersLoaded.fromState(
        copyWith(
          orders: orders ?? this.orders,
          totalItemsCount: totalItemsCount ?? this.totalItemsCount,
        ),
      );
  LoadingMoreOrders loadingMore() => LoadingMoreOrders.fromState(this);
  OrdersLoadLimitReached loadLimitReached() =>
      OrdersLoadLimitReached.fromState(this);
  OrdersLoadingFailed loadingFailed() => OrdersLoadingFailed();
}

final class OrdersInitial extends OrdersState {
  OrdersInitial({
    super.totalItemsCount = 0,
    super.offSet = 0,
    super.orders = const [],
  });
}

final class OrdersLoading extends OrdersInitial {
  OrdersLoading.fromState(OrdersState state)
      : super(
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          orders: state.orders,
        );
}

final class LoadingMoreOrders extends OrdersInitial {
  LoadingMoreOrders.fromState(OrdersState state)
      : super(
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          orders: state.orders,
        );
}

final class OrdersLoaded extends OrdersInitial {
  OrdersLoaded.fromState(OrdersState state)
      : super(
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          orders: state.orders,
        );
}

final class OrdersLoadingFailed extends OrdersInitial {
  OrdersLoadingFailed()
      : super(
          totalItemsCount: 0,
          offSet: 0,
          orders: const [],
        );
}

final class OrdersLoadLimitReached extends OrdersInitial {
  OrdersLoadLimitReached.fromState(OrdersState state)
      : super(
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          orders: state.orders,
        );
}
