import 'package:flutter/widgets.dart';
import 'package:hader_pharm_mobile/models/order_details.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';

class DeligateParahparmOrderItem {
  final bool isParapharm;
  final BaseParaPharmaCatalogModel product;
  final int quantity;
  final double? suggestedPrice;

  DeligateParahparmOrderItem({
    required this.isParapharm,
    required this.product,
    required this.quantity,
    this.suggestedPrice,
  });

  DeligateParahparmOrderItem copyWith({
    int? quantity,
    double? suggestedPrice,
  }) {
    return DeligateParahparmOrderItem(
      isParapharm: isParapharm,
      product: product,
      quantity: quantity ?? this.quantity,
      suggestedPrice: suggestedPrice ?? this.suggestedPrice,
    );
  }
}

class DeligateParahparmOrderItemUi {
  final TextEditingController quantityController;
  final TextEditingController customPriceController;
  final TextEditingController packageQuantityController;

  final DeligateParahparmOrderItem model;

  DeligateParahparmOrderItemUi(
      {required this.quantityController,
      required this.customPriceController,
      required this.packageQuantityController,
      required this.model}) {
    quantityController.text = model.quantity.toString();
    customPriceController.text = model.suggestedPrice.toString();
    packageQuantityController.text =
        (model.quantity ~/ (model.product.packageSize)).toString();
  }

  DeligateParahparmOrderItemUi copyWith(
      {required DeligateParahparmOrderItem model}) {
    return DeligateParahparmOrderItemUi(
        model: model,
        quantityController: quantityController,
        customPriceController: customPriceController,
        packageQuantityController: packageQuantityController);
  }
}

class DeligateOrderItem {
  final bool isParapharm;
  final OrderItem product;
  final int quantity;
  final double? suggestedPrice;

  DeligateOrderItem({
    required this.isParapharm,
    required this.product,
    required this.quantity,
    this.suggestedPrice,
  });

  DeligateOrderItem copyWith({
    int? quantity,
    double? suggestedPrice,
  }) {
    return DeligateOrderItem(
      isParapharm: isParapharm,
      product: product,
      quantity: quantity ?? this.quantity,
      suggestedPrice: suggestedPrice ?? this.suggestedPrice,
    );
  }
}

class DeligateOrderItemUi {
  final TextEditingController quantityController;
  final TextEditingController customPriceController;
  final TextEditingController packageQuantityController;

  final DeligateOrderItem model;

  DeligateOrderItemUi(
      {required this.quantityController,
      required this.customPriceController,
      required this.packageQuantityController,
      required this.model}) {
    quantityController.text = model.quantity.toString();
    customPriceController.text = model.suggestedPrice.toString();
    packageQuantityController.text =
        (model.quantity ~/ (model.product.packageSize)).toString();
  }

  DeligateOrderItemUi copyWith({required DeligateOrderItem model}) {
    return DeligateOrderItemUi(
        model: model,
        quantityController: quantityController,
        customPriceController: customPriceController,
        packageQuantityController: packageQuantityController);
  }
}
