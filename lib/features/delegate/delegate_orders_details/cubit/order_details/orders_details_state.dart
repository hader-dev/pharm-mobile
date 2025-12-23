part of 'orders_details_cubit.dart';

class DelegateOrdersDetails2State {
  final OrderDetailsModel orderData;
  final List<DeligateOrderItemUi> orderItems;
  final List<DeligateOrderItemUi> originalOrderItems;
  final bool didChange;

  const DelegateOrdersDetails2State(
      {required this.orderData, required this.orderItems, required this.originalOrderItems, required this.didChange});

  OrdersInitial toInitial({
    OrderDetailsModel? orderData,
    List<DeligateOrderItemUi>? orderItems,
    bool? didChange,
  }) {
    return OrdersInitial.fromState(
      state: this,
      orderData: orderData,
      orderItems: orderItems,
      didChange: didChange,
    );
  }

  OrderDetailsLoading loading({
    OrderDetailsModel? orderData,
    List<DeligateOrderItemUi>? orderItems,
  }) {
    return OrderDetailsLoading.fromState(
      state: this,
      orderData: orderData,
      orderItems: orderItems,
    );
  }

  OrderDetailsLoaded loaded({
    required OrderDetailsModel orderData,
    required List<DeligateOrderItemUi> orderItems,
    required List<DeligateOrderItemUi> originalOrderItems,
  }) {
    return OrderDetailsLoaded.fromState(
      state: this,
      orderData: orderData,
      orderItems: orderItems,
      originalOrderItems: originalOrderItems,
    );
  }

  OrderDetailsLoadingFailed loadingFailed({
    OrderDetailsModel? orderData,
    List<DeligateOrderItemUi>? orderItems,
  }) {
    return OrderDetailsLoadingFailed.fromState(
      state: this,
      orderData: orderData,
      orderItems: orderItems,
    );
  }

  DelegateOrdersDetails2State toCancelChanges() {
    return OrderItemsUpdated.fromState(
      state: this,
      orderItems: originalOrderItems,
      didChange: false,
    );
  }

  OrderItemsUpdated toItemsUpdated({required DeligateOrderItemUi item, bool removed = false}) {
    bool updatedExisting = false;

    List<DeligateOrderItemUi> updatedOrderItems = orderItems.map((el) {
      final exists = !removed && (el.model.product.paraPharmCatalogId == item.model.product.paraPharmCatalogId);

      if (exists) {
        updatedExisting = true;
        return el.copyWith(
            model: (el.model.copyWith(quantity: item.model.quantity, suggestedPrice: item.model.suggestedPrice)));
      }

      return exists ? item : el;
    }).toList();

    if (removed) {
      updatedOrderItems.remove(item);
    } else if (!updatedExisting) {
      updatedOrderItems.add(item);
    }

    return OrderItemsUpdated.fromState(
      state: this,
      orderItems: updatedOrderItems,
      didChange: true,
    );
  }
}

final class OrdersInitial extends DelegateOrdersDetails2State {
  OrdersInitial(
      {OrderDetailsModel? orderData,
      super.orderItems = const [],
      super.originalOrderItems = const [],
      super.didChange = false})
      : super(orderData: orderData ?? OrderDetailsModel.empty());

  factory OrdersInitial.fromState({
    required DelegateOrdersDetails2State state,
    OrderDetailsModel? orderData,
    List<DeligateOrderItemUi>? orderItems,
    bool? didChange,
  }) {
    return OrdersInitial(
      orderData: orderData ?? state.orderData,
      orderItems: orderItems ?? state.orderItems,
      didChange: didChange ?? state.didChange,
      originalOrderItems: state.originalOrderItems,
    );
  }
}

final class OrderDetailsLoading extends DelegateOrdersDetails2State {
  OrderDetailsLoading({
    required super.orderData,
    required super.didChange,
    super.originalOrderItems = const [],
    super.orderItems = const [],
  });

  factory OrderDetailsLoading.fromState({
    required DelegateOrdersDetails2State state,
    OrderDetailsModel? orderData,
    List<DeligateOrderItemUi>? orderItems,
  }) {
    return OrderDetailsLoading(
      orderData: orderData ?? state.orderData,
      didChange: state.didChange,
      orderItems: orderItems ?? state.orderItems,
    );
  }
}

final class OrderDetailsLoaded extends DelegateOrdersDetails2State {
  OrderDetailsLoaded({
    required super.orderData,
    required super.didChange,
    super.originalOrderItems = const [],
    super.orderItems = const [],
  });

  factory OrderDetailsLoaded.fromState({
    required DelegateOrdersDetails2State state,
    required OrderDetailsModel orderData,
    required List<DeligateOrderItemUi> orderItems,
    required List<DeligateOrderItemUi> originalOrderItems,
  }) {
    return OrderDetailsLoaded(
      orderData: orderData,
      didChange: state.didChange,
      orderItems: orderItems,
      originalOrderItems: originalOrderItems,
    );
  }
}

final class OrderDetailsLoadingFailed extends DelegateOrdersDetails2State {
  OrderDetailsLoadingFailed({
    required super.orderData,
    required super.didChange,
    super.originalOrderItems = const [],
    super.orderItems = const [],
  });

  factory OrderDetailsLoadingFailed.fromState({
    required DelegateOrdersDetails2State state,
    OrderDetailsModel? orderData,
    List<DeligateOrderItemUi>? orderItems,
  }) {
    return OrderDetailsLoadingFailed(
      orderData: orderData ?? state.orderData,
      didChange: state.didChange,
      orderItems: orderItems ?? state.orderItems,
      originalOrderItems: state.originalOrderItems,
    );
  }
}

final class OrderItemsUpdated extends DelegateOrdersDetails2State {
  OrderItemsUpdated.fromState({
    required DelegateOrdersDetails2State state,
    required super.orderItems,
    required super.didChange,
  }) : super(
          orderData: state.orderData,
          originalOrderItems: state.originalOrderItems,
        );
}
