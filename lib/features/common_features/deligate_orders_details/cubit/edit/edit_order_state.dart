part of 'edit_order_cubit.dart';

abstract class DeligateEditOrderState {
  final DelegateClient client;
  final List<BaseParaPharmaCatalogModel> products;
  final List<DeligateParahparmOrderItemUi> orderProducts;

  final bool hasReachedMax;
  final int totalItemsCount;
  final int offSet;
  final int limit;
  final double totalPrice;
  final int quantity;
  final BaseParaPharmaCatalogModel? selectedProduct;
  final double? suggestedPrice;

  final ScrollController scrollController;
  final TextEditingController searchController;
  final TextEditingController customPriceController;
  final TextEditingController quantityController;
  final TextEditingController packageQuantityController;

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
      required this.scrollController,
      required this.searchController,
      required this.customPriceController,
      required this.quantityController,
      required this.packageQuantityController,
      required this.limit});

  DeligateOrderResetSelectedProduct toResetSelectedProduct() {
    return DeligateOrderResetSelectedProduct.fromState(state: this);
  }

  DeligateOrderInitial toInitial({
    DelegateClient? client,
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
    TextEditingController? quantityController,
    TextEditingController? packageQuantityController,
    TextEditingController? customPriceController,
    ScrollController? scrollController,
  }) {
    return DeligateOrderInitial(
      client: resetClient ? DelegateClient.empty() : client ?? this.client,
      products: products,
      hasReachedMax: hasReachedMax,
      totalItemsCount: totalItemsCount,
      selectedProduct: resetSelectedProduct ? null : selectedProduct ?? this.selectedProduct,
      suggestedPrice: resetSuggestedPrice ? null : suggestedPrice ?? this.suggestedPrice,
      quantity: quantity,
      orderProducts: [],
      offSet: offSet,
      limit: limit,
    );
  }

  DeligateOrderUpdateSelectedProduct toUpdateSelectedProduct({required BaseParaPharmaCatalogModel product}) {
    quantityController.text = '1';
    packageQuantityController.text = '0';

    return DeligateOrderUpdateSelectedProduct.fromState(
        state: this,
        selectedProduct: product,
        quantity: 1,
        totalPrice: product.unitPriceHt,
        suggestedPrice: product.unitPriceHt);
  }

  DeligateOrderUpdateSuggestedPrice toUpdateSuggestedPrice({double? price, double? totalPrice, int? quantity}) {
    return DeligateOrderUpdateSuggestedPrice.fromState(
        state: this, suggestedPrice: price, quantity: quantity, totalPrice: totalPrice);
  }

  DeligateOrderLoading toLoading({int? offset}) =>
      DeligateOrderLoading.fromState(state: this, offSet: offset ?? offSet);

  DeligateOrderProductsUpdated toProductsUpdated({required DeligateParahparmOrderItemUi item, bool removed = false}) {
    bool updatedExisting = false;
    List<DeligateParahparmOrderItemUi> orderProducts = this.orderProducts.map((el) {
      final exists = !removed && el.model.product.id == item.model.product.id;

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

    return DeligateOrderProductsUpdated.fromState(state: this, orderProducts: orderProducts);
  }

  DeligateOrderClientUpdated toClientUpdated({required DelegateClient client}) {
    return DeligateOrderClientUpdated.fromState(state: this, client: client);
  }

  DeligateOrderLoaded toLoaded({
    List<BaseParaPharmaCatalogModel>? products,
    bool? hasReachedMax,
    int? totalItemsCount,
  }) =>
      DeligateOrderLoaded.fromState(
          state: this,
          products: products ?? this.products,
          hasReachedMax: hasReachedMax ?? this.hasReachedMax,
          totalItemsCount: totalItemsCount ?? this.totalItemsCount);

  DeligateOrderLoadLimitReached toLimitReached() => DeligateOrderLoadLimitReached.fromState(this);

  DeligateOrderLoadingFailed toFailed(String message) => DeligateOrderLoadingFailed.fromState(this, message: message);
}

final class DeligateOrderInitial extends DeligateEditOrderState {
  DeligateOrderInitial({
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
    ScrollController? scrollController,
    TextEditingController? searchController,
    TextEditingController? quantityController,
    TextEditingController? packageQuantityController,
    TextEditingController? customPriceController,
  }) : super(
          scrollController: scrollController ?? ScrollController(),
          searchController: searchController ?? TextEditingController(),
          quantityController: quantityController ?? TextEditingController(text: "1"),
          packageQuantityController: packageQuantityController ?? TextEditingController(text: "1"),
          customPriceController: customPriceController ?? TextEditingController(),
        );
}

final class DeligateOrderLoading extends DeligateEditOrderState {
  DeligateOrderLoading.fromState({required DeligateEditOrderState state, int? offSet})
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
          offSet: offSet ?? state.offSet,
          limit: state.limit,
          scrollController: state.scrollController,
          searchController: state.searchController,
          quantityController: state.quantityController,
          packageQuantityController: state.packageQuantityController,
          customPriceController: state.customPriceController,
        );
}

final class DeligateOrderClientUpdated extends DeligateEditOrderState {
  DeligateOrderClientUpdated.fromState({
    required DeligateEditOrderState state,
    required super.client,
  }) : super(
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
          scrollController: state.scrollController,
          searchController: state.searchController,
          quantityController: state.quantityController,
          packageQuantityController: state.packageQuantityController,
          customPriceController: state.customPriceController,
        );
}

final class DeligateOrderProductsUpdated extends DeligateEditOrderState {
  DeligateOrderProductsUpdated.fromState({
    required DeligateEditOrderState state,
    required super.orderProducts,
  }) : super(
          hasReachedMax: state.hasReachedMax,
          client: state.client,
          totalPrice: state.totalPrice,
          selectedProduct: state.selectedProduct,
          suggestedPrice: state.suggestedPrice,
          quantity: state.quantity,
          totalItemsCount: orderProducts.length,
          offSet: state.offSet,
          products: state.products,
          limit: state.limit,
          scrollController: state.scrollController,
          searchController: state.searchController,
          quantityController: state.quantityController,
          packageQuantityController: state.packageQuantityController,
          customPriceController: state.customPriceController,
        );
}

final class DeligateOrderUpdateSelectedProduct extends DeligateEditOrderState {
  DeligateOrderUpdateSelectedProduct.fromState(
      {required DeligateEditOrderState state,
      required BaseParaPharmaCatalogModel super.selectedProduct,
      required super.quantity,
      required super.totalPrice,
      required double super.suggestedPrice})
      : super(
          client: state.client,
          hasReachedMax: state.hasReachedMax,
          orderProducts: state.orderProducts,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          products: state.products,
          limit: state.limit,
          scrollController: state.scrollController,
          searchController: state.searchController,
          quantityController: state.quantityController,
          packageQuantityController: state.packageQuantityController,
          customPriceController: state.customPriceController,
        );
}

final class DeligateOrderResetSelectedProduct extends DeligateEditOrderState {
  DeligateOrderResetSelectedProduct.fromState({
    required DeligateEditOrderState state,
  }) : super(
          client: state.client,
          hasReachedMax: state.hasReachedMax,
          orderProducts: state.orderProducts,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          products: state.products,
          limit: state.limit,
          scrollController: state.scrollController,
          searchController: state.searchController,
          quantityController: state.quantityController,
          packageQuantityController: state.packageQuantityController,
          customPriceController: state.customPriceController,
          suggestedPrice: state.suggestedPrice,
          selectedProduct: null,
          quantity: 1,
          totalPrice: 0,
        );
}

final class DeligateOrderUpdateSuggestedPrice extends DeligateEditOrderState {
  DeligateOrderUpdateSuggestedPrice.fromState(
      {required DeligateEditOrderState state, int? quantity, double? totalPrice, double? suggestedPrice})
      : super(
          suggestedPrice: suggestedPrice ?? state.suggestedPrice,
          quantity: quantity ?? state.quantity,
          totalPrice: totalPrice ?? state.totalPrice,
          client: state.client,
          hasReachedMax: state.hasReachedMax,
          orderProducts: state.orderProducts,
          totalItemsCount: state.totalItemsCount,
          offSet: state.offSet,
          products: state.products,
          selectedProduct: state.selectedProduct,
          limit: state.limit,
          scrollController: state.scrollController,
          searchController: state.searchController,
          quantityController: state.quantityController,
          packageQuantityController: state.packageQuantityController,
          customPriceController: state.customPriceController,
        );
}

final class DeligateOrderLoaded extends DeligateEditOrderState {
  DeligateOrderLoaded.fromState({
    required DeligateEditOrderState state,
    required super.products,
    bool? hasReachedMax,
    int? totalItemsCount,
  }) : super(
          client: state.client,
          hasReachedMax: hasReachedMax ?? state.hasReachedMax,
          orderProducts: state.orderProducts,
          selectedProduct: state.selectedProduct,
          suggestedPrice: state.suggestedPrice,
          totalPrice: state.totalPrice,
          quantity: state.quantity,
          totalItemsCount: totalItemsCount ?? state.totalItemsCount,
          offSet: state.offSet,
          limit: state.limit,
          scrollController: state.scrollController,
          searchController: state.searchController,
          quantityController: state.quantityController,
          packageQuantityController: state.packageQuantityController,
          customPriceController: state.customPriceController,
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
          scrollController: state.scrollController,
          searchController: state.searchController,
          quantityController: state.quantityController,
          packageQuantityController: state.packageQuantityController,
          customPriceController: state.customPriceController,
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
          scrollController: state.scrollController,
          searchController: state.searchController,
          quantityController: state.quantityController,
          packageQuantityController: state.packageQuantityController,
          customPriceController: state.customPriceController,
        );
}
