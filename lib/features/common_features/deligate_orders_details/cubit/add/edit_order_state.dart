part of 'edit_order_cubit.dart';

abstract class DeligateEditOrderState extends Equatable {
  final DeligateClient client;
  final List<BaseParaPharmaCatalogModel> products;
  final List<DeligateParahparmOrderItem> orderProducts;

  final bool hasReachedMax;
  final int totalItemsCount;
  final int offSet;
  final int limit;
  final double totalPrice;
  final int quantity;
  final BaseParaPharmaCatalogModel? selectedProduct;
  final double? suggestedPrice;

  const DeligateEditOrderState(
      {required this.client,
      required this.products,
      required this.totalPrice,
      required this.orderProducts,
      this.selectedProduct,
      required this.suggestedPrice,
      required this.hasReachedMax,
      required this.quantity,
      required this.totalItemsCount,
      required this.offSet,
      required this.limit});

  @override
  List<Object?> get props => [
        client,
        products,
        orderProducts,
        hasReachedMax,
        totalItemsCount,
        offSet,
        quantity,
        limit,
        totalPrice,
        suggestedPrice,
        selectedProduct,
      ];

  DeligateEditOrderState copyWith({
    DeligateClient? client,
    List<BaseParaPharmaCatalogModel>? products,
    List<DeligateParahparmOrderItem>? orderProducts,
    bool? hasReachedMax,
    int? totalItemsCount,
    int? offSet,
    int? quantity,
    int? limit,
    double? totalPrice,
    double? suggestedPrice,
    BaseParaPharmaCatalogModel? selectedProduct,
  }) {
    return DeligateOrderInitial(
      quantity: quantity ?? this.quantity,
      suggestedPrice: suggestedPrice ?? this.suggestedPrice,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      client: client ?? this.client,
      orderProducts: orderProducts ?? this.orderProducts,
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      totalItemsCount: totalItemsCount ?? this.totalItemsCount,
      offSet: offSet ?? this.offSet,
      limit: limit ?? this.limit,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  DeligateOrderInitial initial({
    DeligateClient? client,
    bool resetClient = false,
    List<BaseParaPharmaCatalogModel> products = const [],
    bool hasReachedMax = false,
    bool resetSuggestedPrice = false,
    int totalItemsCount = 0,
    double? suggestedPrice,
    int offSet = 0,
    int quantity = 1,
    int limit = 20,
    bool resetSelectedProduct = false,
    BaseParaPharmaCatalogModel? selectedProduct,
  }) {
    return DeligateOrderInitial(
      client: resetClient ? DeligateClient.empty() : client ?? this.client,
      products: products,
      hasReachedMax: hasReachedMax,
      totalItemsCount: totalItemsCount,
      selectedProduct:
          resetSelectedProduct ? null : selectedProduct ?? this.selectedProduct,
      suggestedPrice:
          resetSuggestedPrice ? null : suggestedPrice ?? this.suggestedPrice,
      quantity: quantity,
      orderProducts: [],
      offSet: offSet,
      limit: limit,
    );
  }

  DeligateOrderUpdateSelectedProduct updateSelectedProduct(
      {required BaseParaPharmaCatalogModel product}) {
    return DeligateOrderUpdateSelectedProduct.fromState(
      copyWith(
          selectedProduct: product,
          quantity: 1,
          totalPrice: double.parse(product.unitPriceHt),
          suggestedPrice: double.parse(product.unitPriceHt)),
    );
  }

  DeligateOrderUpdateSuggestedPrice updateSuggestedPrice(
      {double? price, double? totalPrice, int? quantity}) {
    return DeligateOrderUpdateSuggestedPrice.fromState(
      copyWith(
          suggestedPrice: price, quantity: quantity, totalPrice: totalPrice),
    );
  }

  DeligateOrderLoading loading({int? offset}) =>
      DeligateOrderLoading.fromState(copyWith(offSet: offset ?? offSet));

  DeligateOrderProductsUpdated productsUpdated(
      {required DeligateParahparmOrderItem item, bool removed = false}) {
    bool updatedExisting = false;
    List<DeligateParahparmOrderItem> orderProducts =
        this.orderProducts.map((el) {
      final exists = !removed && el.product.id == item.product.id;

      if (exists) {
        updatedExisting = true;
      }

      return exists ? item : el;
    }).toList();

    if (removed) {
      orderProducts.remove(item);
    } else if (!updatedExisting) {
      orderProducts.add(item);
    }

    return DeligateOrderProductsUpdated.fromState(
        copyWith(orderProducts: orderProducts));
  }

  DeligateOrderClientUpdated clientUpdated({required DeligateClient client}) {
    return DeligateOrderClientUpdated.fromState(copyWith(client: client));
  }

  DeligateOrderLoaded loaded({
    List<BaseParaPharmaCatalogModel>? products,
    bool? hasReachedMax,
    int? totalItemsCount,
  }) =>
      DeligateOrderLoaded.fromState(
        copyWith(
          products: products ?? this.products,
          hasReachedMax: hasReachedMax ?? this.hasReachedMax,
          totalItemsCount: totalItemsCount ?? this.totalItemsCount,
        ),
      );

  DeligateOrderLoadLimitReached limitReached() =>
      DeligateOrderLoadLimitReached.fromState(this);

  DeligateOrderLoadingFailed failed(String message) =>
      DeligateOrderLoadingFailed.fromState(this, message: message);
}

final class DeligateOrderInitial extends DeligateEditOrderState {
  const DeligateOrderInitial({
    required super.client,
    super.products = const [],
    super.orderProducts = const [],
    super.hasReachedMax = false,
    super.totalItemsCount = 0,
    super.quantity = 1,
    super.selectedProduct,
    super.offSet = 0,
    super.totalPrice = 0,
    super.limit = 20,
    super.suggestedPrice,
  });
}

final class DeligateOrderLoading extends DeligateEditOrderState {
  DeligateOrderLoading.fromState(DeligateEditOrderState state)
      : super(
          client: state.client,
          selectedProduct: state.selectedProduct,
          suggestedPrice: state.suggestedPrice,
          quantity: state.quantity,
          products: state.products,
          hasReachedMax: state.hasReachedMax,
          totalPrice: state.totalPrice,
          totalItemsCount: state.totalItemsCount,
          orderProducts: state.orderProducts,
          offSet: state.offSet,
          limit: state.limit,
        );
}

final class DeligateOrderClientUpdated extends DeligateEditOrderState {
  DeligateOrderClientUpdated.fromState(
    DeligateEditOrderState state,
  ) : super(
          client: state.client,
          selectedProduct: state.selectedProduct,
          suggestedPrice: state.suggestedPrice,
          quantity: state.quantity,
          totalPrice: state.totalPrice,
          hasReachedMax: state.hasReachedMax,
          orderProducts: state.orderProducts,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          products: state.products,
          limit: state.limit,
        );
}

final class DeligateOrderProductsUpdated extends DeligateEditOrderState {
  DeligateOrderProductsUpdated.fromState(
    DeligateEditOrderState state,
  ) : super(
          hasReachedMax: state.hasReachedMax,
          client: state.client,
          totalPrice: state.totalPrice,
          selectedProduct: state.selectedProduct,
          suggestedPrice: state.suggestedPrice,
          quantity: state.quantity,
          orderProducts: state.orderProducts,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          products: state.products,
          limit: state.limit,
        );
}

final class DeligateOrderUpdateSelectedProduct
    extends DeligateEditOrderState {
  DeligateOrderUpdateSelectedProduct.fromState(DeligateEditOrderState state)
      : super(
          client: state.client,
          hasReachedMax: state.hasReachedMax,
          totalPrice: state.totalPrice,
          orderProducts: state.orderProducts,
          selectedProduct: state.selectedProduct,
          suggestedPrice: state.suggestedPrice,
          quantity: state.quantity,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          products: state.products,
          limit: state.limit,
        );
}

final class DeligateOrderUpdateSuggestedPrice extends DeligateEditOrderState {
  DeligateOrderUpdateSuggestedPrice.fromState(DeligateEditOrderState state)
      : super(
          client: state.client,
          hasReachedMax: state.hasReachedMax,
          orderProducts: state.orderProducts,
          selectedProduct: state.selectedProduct,
          suggestedPrice: state.suggestedPrice,
          quantity: state.quantity,
          totalPrice: state.totalPrice,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          products: state.products,
          limit: state.limit,
        );
}

final class DeligateOrderLoaded extends DeligateEditOrderState {
  DeligateOrderLoaded.fromState(DeligateEditOrderState state)
      : super(
          client: state.client,
          hasReachedMax: state.hasReachedMax,
          orderProducts: state.orderProducts,
          selectedProduct: state.selectedProduct,
          suggestedPrice: state.suggestedPrice,
          totalPrice: state.totalPrice,
          quantity: state.quantity,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          products: state.products,
          limit: state.limit,
        );
}

final class DeligateOrderLoadLimitReached extends DeligateEditOrderState {
  DeligateOrderLoadLimitReached.fromState(DeligateEditOrderState state)
      : super(
          client: state.client,
          hasReachedMax: true,
          orderProducts: state.orderProducts,
          totalPrice: state.totalPrice,
          selectedProduct: state.selectedProduct,
          suggestedPrice: state.suggestedPrice,
          quantity: state.quantity,
          products: state.products,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          limit: state.limit,
        );
}

final class DeligateOrderLoadingFailed extends DeligateEditOrderState {
  final String message;

  DeligateOrderLoadingFailed.fromState(
    DeligateEditOrderState state, {
    required this.message,
  }) : super(
          client: state.client,
          orderProducts: state.orderProducts,
          totalPrice: state.totalPrice,
          products: state.products,
          hasReachedMax: state.hasReachedMax,
          selectedProduct: state.selectedProduct,
          suggestedPrice: state.suggestedPrice,
          quantity: state.quantity,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          limit: state.limit,
        );

  @override
  List<Object> get props => [client, hasReachedMax, message];
}
