import 'package:equatable/equatable.dart';

import '../config/services/network/network_manager.dart';
import 'create_cart_item.dart';
import 'productDetails.dart';

class CartItemArticle extends BaseArticle with EquatableMixin {
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final int? tvaPercentage;
  final String? price;
  final List<BaseOptionValue>? optionValues;

  CartItemArticle({
    required super.id,
    this.createdAt,
    this.updatedAt,
    required super.label,
    super.imgPath,
    this.tvaPercentage,
    this.price,
    this.optionValues,
  });

  @override
  List<Object?> get props => <Object?>[id];

  factory CartItemArticle.fromJson(Map<String, dynamic> json) {
    return CartItemArticle(
      id: json['id'],
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
      label: json['label'] ?? "",
      imgPath: NetworkManager.instance.getImagePath(json['imgPath']) ?? "",
      tvaPercentage: json['tvaPercentage'] ?? 0,
      price: json['price'] ?? "",
      optionValues: (json['optionValues'] as List?)?.map((item) => BaseOptionValue.fromJson(item)).toList() ??
          <BaseOptionValue>[],
    );
  }
  CreateCartItemModel createCartItem(int quantity) {
    return CreateCartItemModel(
      articleId: id,
      quantity: quantity,
    );
  }
}
