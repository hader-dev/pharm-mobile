part of 'create_order_cubit.dart';

abstract class DeligateCreateOrderState extends Equatable {
  final DeligateClient client;
  final List<BaseParaPharmaCatalogModel> products;
  final List<DeligateParahparmOrderItemUi> orderProducts;
  final String shippingAddress;

  final bool hasReachedMax;
  final int totalItemsCount;
  final int offSet;
  final int limit;
  final double totalPrice;
  final int quantity;
  final BaseParaPharmaCatalogModel? selectedProduct;
  final double? suggestedPrice;
  final double totalHtAmount;
  final double totalTtcAmount;
  final String orderNote;

  final PaymentMethods selectedPaymentMethod;
  final InvoiceTypes selectedInvoiceType;

  final ScrollController scrollController;
  final TextEditingController searchController;
  final TextEditingController customPriceController;
  final TextEditingController quantityController;
  final TextEditingController packageQuantityController;

  const DeligateCreateOrderState(
      {required this.client,
      required this.products,
      required this.shippingAddress,
      required this.totalPrice,
      required this.orderProducts,
      this.selectedProduct,
      required this.suggestedPrice,
      required this.hasReachedMax,
      required this.quantity,
      required this.totalItemsCount,
      required this.offSet,
      required this.limit,
      required this.scrollController,
      required this.orderNote,
      required this.searchController,
      required this.customPriceController,
      required this.quantityController,
      required this.packageQuantityController,
      required this.totalHtAmount,
      required this.selectedPaymentMethod,
      required this.selectedInvoiceType,
      required this.totalTtcAmount});

  DeligateOrderUpdateMiscs toUpdateMiscs({
    String? orderNote,
    String? shippingAddress,
    PaymentMethods? selectedPaymentMethod,
    InvoiceTypes? selectedInvoiceType,
  }) {
    return DeligateOrderUpdateMiscs.fromState(
      state: this,
      orderNote: orderNote,
      shippingAddress: shippingAddress,
      selectedPaymentMethod: selectedPaymentMethod,
      selectedInvoiceType: selectedInvoiceType,
    );
  }

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
        totalHtAmount,
        totalTtcAmount,
        orderNote
      ];

  static double calculateTotalAmountTtc(
      List<DeligateParahparmOrderItemUi> items) {
    double totalAmount = 0;
    for (var element in items) {
      totalAmount += element.model.getTotalPrice()["totalTTCPrice"]!;
    }
    return totalAmount;
  }

  static double calculateTotalAmountHt(
      List<DeligateParahparmOrderItemUi> items) {
    double totalAmount = 0;
    for (var element in items) {
      totalAmount += element.model.getTotalPrice()["totalHtPrice"]!;
    }
    return totalAmount;
  }

  DeligateOrderInitial toInitial({
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
      shippingAddress: shippingAddress,
      totalPrice: 0,
      orderNote: "",
      totalHtAmount: 0,
      totalTtcAmount: 0,
    );
  }

  DeligateOrderUpdateSelectedProduct toUpdateSelectedProduct(
      {required BaseParaPharmaCatalogModel product}) {
    quantityController.text = '1';
    packageQuantityController.text = '0';
    return DeligateOrderUpdateSelectedProduct.fromState(
      state: this,
      selectedProduct: product,
      quantity: 1,
      totalPrice: product.unitPriceHt,
      suggestedPrice: product.unitPriceHt,
    );
  }

  DeligateOrderUpdateSuggestedPrice toUpdateSuggestedPrice(
      {double? price, double? totalPrice, int? quantity}) {
    return DeligateOrderUpdateSuggestedPrice.fromState(
      state: this,
      suggestedPrice: price,
      quantity: quantity,
      totalPrice: totalPrice,
    );
  }

  DeligateOrderLoading toLoading({int? offset}) =>
      DeligateOrderLoading.fromState(state: this, offset: offset ?? offSet);

  DeligateOrderProductsUpdated toProductsUpdated(
      {required DeligateParahparmOrderItemUi item,
      bool removed = false,
      bool resetSelectedProduct = false}) {
    bool updatedExisting = false;
    List<DeligateParahparmOrderItemUi> orderProducts =
        this.orderProducts.map((el) {
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

    return DeligateOrderProductsUpdated.fromState(
        state: this,
        orderProducts: orderProducts,
        selectedProduct: resetSelectedProduct ? null : item.model.product);
  }

  DeligateOrderClientUpdated toClientUpdated({required DeligateClient client}) {
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
        totalItemsCount: totalItemsCount ?? this.totalItemsCount,
      );

  DeligateOrderLoadLimitReached toLimitReached() =>
      DeligateOrderLoadLimitReached.fromState(this);

  DeligateOrderLoadingFailed toFailed(String message) =>
      DeligateOrderLoadingFailed.fromState(this, message: message);

  DeligateCreateOrderState toClearProducts() {
    return DeligateOrderInitial(
        client: client,
        products: [],
        hasReachedMax: false,
        totalItemsCount: 0,
        selectedProduct: null,
        suggestedPrice: null,
        quantity: 1,
        orderProducts: [],
        offSet: 0,
        limit: 20,
        shippingAddress: shippingAddress);
  }
}

final class DeligateOrderInitial extends DeligateCreateOrderState {
  DeligateOrderInitial(
      {required super.client,
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
      super.totalHtAmount = 0,
      super.totalTtcAmount = 0,
      super.orderNote = "",
      required super.shippingAddress,
      ScrollController? scrollController,
      TextEditingController? searchController,
      TextEditingController? customPriceController,
      TextEditingController? quantityController,
      TextEditingController? packageQuantityController,
      PaymentMethods? selectedPaymentMethod,
      InvoiceTypes? selectedInvoiceType})
      : super(
            scrollController: scrollController ?? ScrollController(),
            searchController: searchController ?? TextEditingController(),
            customPriceController:
                customPriceController ?? TextEditingController(),
            quantityController: quantityController ?? TextEditingController(),
            packageQuantityController:
                packageQuantityController ?? TextEditingController(),
            selectedPaymentMethod: selectedPaymentMethod ?? PaymentMethods.cash,
            selectedInvoiceType: selectedInvoiceType ?? InvoiceTypes.proforma);
}

final class DeligateOrderLoading extends DeligateCreateOrderState {
  DeligateOrderLoading.fromState(
      {required DeligateCreateOrderState state, int? offset})
      : super(
            offSet: offset ?? state.offSet,
            client: state.client,
            selectedProduct: state.selectedProduct,
            suggestedPrice: state.suggestedPrice,
            quantity: state.quantity,
            products: state.products,
            hasReachedMax: state.hasReachedMax,
            totalPrice: state.totalPrice,
            totalItemsCount: state.totalItemsCount,
            orderProducts: state.orderProducts,
            limit: state.limit,
            scrollController: state.scrollController,
            searchController: state.searchController,
            customPriceController: state.customPriceController,
            quantityController: state.quantityController,
            packageQuantityController: state.packageQuantityController,
            totalHtAmount: state.totalHtAmount,
            totalTtcAmount: state.totalTtcAmount,
            orderNote: state.orderNote,
            shippingAddress: state.shippingAddress,
            selectedPaymentMethod: state.selectedPaymentMethod,
            selectedInvoiceType: state.selectedInvoiceType);
}

final class DeligateOrderClientUpdated extends DeligateCreateOrderState {
  DeligateOrderClientUpdated.fromState({
    required DeligateCreateOrderState state,
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
            customPriceController: state.customPriceController,
            quantityController: state.quantityController,
            packageQuantityController: state.packageQuantityController,
            totalHtAmount: state.totalHtAmount,
            totalTtcAmount: state.totalTtcAmount,
            orderNote: state.orderNote,
            shippingAddress: state.shippingAddress,
            selectedPaymentMethod: state.selectedPaymentMethod,
            selectedInvoiceType: state.selectedInvoiceType);
}

final class DeligateOrderProductsUpdated extends DeligateCreateOrderState {
  DeligateOrderProductsUpdated.fromState(
      {required DeligateCreateOrderState state,
      required super.orderProducts,
      required super.selectedProduct})
      : super(
            hasReachedMax: state.hasReachedMax,
            client: state.client,
            totalPrice: state.totalPrice,
            suggestedPrice: state.suggestedPrice,
            quantity: state.quantity,
            totalItemsCount: orderProducts.length,
            offSet: state.offSet,
            products: state.products,
            limit: state.limit,
            scrollController: state.scrollController,
            searchController: state.searchController,
            customPriceController: state.customPriceController,
            quantityController: state.quantityController,
            packageQuantityController: state.packageQuantityController,
            totalHtAmount:
                DeligateCreateOrderState.calculateTotalAmountHt(orderProducts),
            totalTtcAmount:
                DeligateCreateOrderState.calculateTotalAmountTtc(orderProducts),
            orderNote: state.orderNote,
            shippingAddress: state.shippingAddress,
            selectedPaymentMethod: state.selectedPaymentMethod,
            selectedInvoiceType: state.selectedInvoiceType);
}

final class DeligateOrderUpdateSelectedProduct
    extends DeligateCreateOrderState {
  DeligateOrderUpdateSelectedProduct.fromState(
      {required DeligateCreateOrderState state,
      required super.selectedProduct,
      required super.quantity,
      required super.totalPrice,
      required super.suggestedPrice})
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
            customPriceController: state.customPriceController,
            quantityController: state.quantityController,
            packageQuantityController: state.packageQuantityController,
            totalHtAmount: state.totalHtAmount,
            totalTtcAmount: state.totalTtcAmount,
            orderNote: state.orderNote,
            shippingAddress: state.shippingAddress,
            selectedPaymentMethod: state.selectedPaymentMethod,
            selectedInvoiceType: state.selectedInvoiceType);
}

final class DeligateOrderUpdateSuggestedPrice extends DeligateCreateOrderState {
  DeligateOrderUpdateSuggestedPrice.fromState({
    required DeligateCreateOrderState state,
    required super.suggestedPrice,
    int? quantity,
    double? totalPrice,
  }) : super(
            quantity: quantity ?? state.quantity,
            totalPrice: totalPrice ?? state.totalPrice,
            client: state.client,
            hasReachedMax: state.hasReachedMax,
            orderProducts: state.orderProducts,
            selectedProduct: state.selectedProduct,
            totalItemsCount: state.totalItemsCount,
            offSet: state.offSet,
            products: state.products,
            limit: state.limit,
            scrollController: state.scrollController,
            searchController: state.searchController,
            customPriceController: state.customPriceController,
            quantityController: state.quantityController,
            packageQuantityController: state.packageQuantityController,
            totalHtAmount: state.totalHtAmount,
            totalTtcAmount: state.totalTtcAmount,
            orderNote: state.orderNote,
            shippingAddress: state.shippingAddress,
            selectedPaymentMethod: state.selectedPaymentMethod,
            selectedInvoiceType: state.selectedInvoiceType);
}

final class DeligateOrderLoaded extends DeligateCreateOrderState {
  DeligateOrderLoaded.fromState({
    required DeligateCreateOrderState state,
    required super.products,
    required super.hasReachedMax,
    required super.totalItemsCount,
  }) : super(
            client: state.client,
            orderProducts: state.orderProducts,
            selectedProduct: state.selectedProduct,
            suggestedPrice: state.suggestedPrice,
            totalPrice: state.totalPrice,
            quantity: state.quantity,
            offSet: state.offSet,
            limit: state.limit,
            scrollController: state.scrollController,
            searchController: state.searchController,
            customPriceController: state.customPriceController,
            quantityController: state.quantityController,
            packageQuantityController: state.packageQuantityController,
            totalHtAmount: state.totalHtAmount,
            totalTtcAmount: state.totalTtcAmount,
            orderNote: state.orderNote,
            shippingAddress: state.shippingAddress,
            selectedPaymentMethod: state.selectedPaymentMethod,
            selectedInvoiceType: state.selectedInvoiceType);
}

final class DeligateOrderLoadLimitReached extends DeligateCreateOrderState {
  DeligateOrderLoadLimitReached.fromState(DeligateCreateOrderState state)
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
            customPriceController: state.customPriceController,
            quantityController: state.quantityController,
            packageQuantityController: state.packageQuantityController,
            totalHtAmount: state.totalHtAmount,
            totalTtcAmount: state.totalTtcAmount,
            orderNote: state.orderNote,
            shippingAddress: state.shippingAddress,
            selectedPaymentMethod: state.selectedPaymentMethod,
            selectedInvoiceType: state.selectedInvoiceType);
}

final class DeligateOrderUpdateMiscs extends DeligateCreateOrderState {
  DeligateOrderUpdateMiscs.fromState({
    required DeligateCreateOrderState state,
    String? orderNote,
    String? shippingAddress,
    PaymentMethods? selectedPaymentMethod,
    InvoiceTypes? selectedInvoiceType,
  }) : super(
            client: state.client,
            hasReachedMax: state.hasReachedMax,
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
            customPriceController: state.customPriceController,
            quantityController: state.quantityController,
            packageQuantityController: state.packageQuantityController,
            totalHtAmount: state.totalHtAmount,
            totalTtcAmount: state.totalTtcAmount,
            orderNote: orderNote ?? state.orderNote,
            shippingAddress: shippingAddress ?? state.shippingAddress,
            selectedPaymentMethod:
                selectedPaymentMethod ?? state.selectedPaymentMethod,
            selectedInvoiceType:
                selectedInvoiceType ?? state.selectedInvoiceType);
}

final class DeligateOrderLoadingFailed extends DeligateCreateOrderState {
  final String message;

  DeligateOrderLoadingFailed.fromState(
    DeligateCreateOrderState state, {
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
            customPriceController: state.customPriceController,
            quantityController: state.quantityController,
            packageQuantityController: state.packageQuantityController,
            totalHtAmount: state.totalHtAmount,
            totalTtcAmount: state.totalTtcAmount,
            orderNote: state.orderNote,
            shippingAddress: state.shippingAddress,
            selectedPaymentMethod: state.selectedPaymentMethod,
            selectedInvoiceType: state.selectedInvoiceType);

  @override
  List<Object> get props => [client, hasReachedMax, message];
}
