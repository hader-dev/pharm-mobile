part of 'orders_details_cubit.dart';

class OrdersDetailsState {
  final OrderDetailsModel orderData;
  final List<DeligateOrderItem> orderItems;
  final List<DeligateOrderItem> originalOrderItems;
  final bool didChange;

  const OrdersDetailsState(
      {required this.orderData,
      required this.orderItems,
      required this.originalOrderItems,
      required this.didChange});

  OrdersDetailsState copyWith({
    OrderDetailsModel? orderData,
    List<DeligateOrderItem>? orderItems,
    List<DeligateOrderItem>? originalOrderItems,
    bool? didChange,
  }) {
    return OrdersDetailsState(
      orderData: orderData ?? this.orderData,
      didChange: didChange ?? this.didChange,
      orderItems: orderItems ?? this.orderItems,
      originalOrderItems: originalOrderItems ?? this.originalOrderItems,
    );
  }

  OrdersInitial initial({
    OrderDetailsModel? orderData,
    List<DeligateOrderItem>? orderItems,
    bool? didChange,
  }) {
    return OrdersInitial.fromState(copyWith(
      orderData: orderData ?? this.orderData,
      orderItems: orderItems ?? this.orderItems,
      originalOrderItems: originalOrderItems,
      didChange: didChange ?? this.didChange,
    ));
  }

  OrderDetailsLoading loading({
    OrderDetailsModel? orderData,
    List<DeligateOrderItem>? orderItems,
  }) {
    return OrderDetailsLoading.fromState(copyWith(
      orderData: orderData ?? this.orderData,
      orderItems: orderItems ?? this.orderItems,
      originalOrderItems: originalOrderItems,
    ));
  }

  OrderDetailsLoaded loaded({
    OrderDetailsModel? orderData,
    List<DeligateOrderItem>? orderItems,
    List<DeligateOrderItem>? originalOrderItems,
  }) {
    return OrderDetailsLoaded.fromState(copyWith(
      orderData: orderData ?? this.orderData,
      orderItems: orderItems ?? this.orderItems,
      originalOrderItems: originalOrderItems ?? this.originalOrderItems,
    ));
  }

  OrderDetailsLoadingFailed loadingFailed({
    OrderDetailsModel? orderData,
    List<DeligateOrderItem>? orderItems,
  }) {
    return OrderDetailsLoadingFailed.fromState(copyWith(
      orderData: orderData ?? this.orderData,
      orderItems: orderItems ?? this.orderItems,
      originalOrderItems: originalOrderItems,
    ));
  }

  OrdersDetailsState cancelChanges() {
    return copyWith(
      orderItems: originalOrderItems,
      didChange: false,
    );
  }

  OrderItemsUpdated itemsUpdated(
      {required DeligateOrderItem item, bool removed = false}) {
    bool updatedExisting = false;

    List<DeligateOrderItem> updatedOrderItems = orderItems.map((el) {
      final exists = !removed &&
          (el.product.parapharmCatalogId == item.product.parapharmCatalogId);

      if (exists) {
        updatedExisting = true;
        return el.copyWith(
            quantity: item.quantity, suggestedPrice: item.suggestedPrice);
      }

      return exists ? item : el;
    }).toList();

    if (removed) {
      updatedOrderItems.remove(item);
    } else if (!updatedExisting) {
      updatedOrderItems.add(item);
    }

    return OrderItemsUpdated.fromState(
        copyWith(orderItems: updatedOrderItems, didChange: true));
  }
}

final class OrdersInitial extends OrdersDetailsState {
  OrdersInitial(
      {OrderDetailsModel? orderData,
      super.orderItems = const [],
      super.originalOrderItems = const [],
      super.didChange = false})
      : super(orderData: orderData ?? OrderDetailsModel.empty());

  factory OrdersInitial.fromState(OrdersDetailsState state) {
    return OrdersInitial(
      orderData: state.orderData,
      orderItems: state.orderItems,
      didChange: state.didChange,
      originalOrderItems: state.originalOrderItems,
    );
  }
}

final class OrderDetailsLoading extends OrdersDetailsState {
  OrderDetailsLoading({
    required super.orderData,
    required super.didChange,
    super.originalOrderItems = const [],
    super.orderItems = const [],
  });

  factory OrderDetailsLoading.fromState(OrdersDetailsState state) {
    return OrderDetailsLoading(
      orderData: state.orderData,
      didChange: state.didChange,
      orderItems: state.orderItems,
    );
  }
}

final class OrderDetailsLoaded extends OrdersDetailsState {
  OrderDetailsLoaded({
    required super.orderData,
    required super.didChange,
    super.originalOrderItems = const [],
    super.orderItems = const [],
  });

  factory OrderDetailsLoaded.fromState(OrdersDetailsState state) {
    return OrderDetailsLoaded(
      orderData: state.orderData,
      didChange: state.didChange,
      orderItems: state.orderItems,
      originalOrderItems: state.originalOrderItems,
    );
  }
}

final class OrderDetailsLoadingFailed extends OrdersDetailsState {
  OrderDetailsLoadingFailed({
    required super.orderData,
    required super.didChange,
    super.originalOrderItems = const [],
    super.orderItems = const [],
  });

  factory OrderDetailsLoadingFailed.fromState(OrdersDetailsState state) {
    return OrderDetailsLoadingFailed(
      orderData: state.orderData,
      didChange: state.didChange,
      orderItems: state.orderItems,
    );
  }
}

final class OrderItemsUpdated extends OrdersDetailsState {
  OrderItemsUpdated.fromState(
    OrdersDetailsState state,
  ) : super(
          orderData: state.orderData,
          didChange: state.didChange,
          originalOrderItems: state.originalOrderItems,
          orderItems: state.orderItems,
        );
}
