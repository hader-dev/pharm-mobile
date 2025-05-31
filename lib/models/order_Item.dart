import 'productDetails.dart';

class OrderItem {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int quantity;
  final String? note;
  final int offset;
  final String articleRef;
  final String articleLabel;
  final double discount;
  final int discountPercentage;
  final double unitePriceHt;
  final double unitePriceTtc;
  final bool isOutStock;
  final int articleId;
  final int orderId;
  final BaseArticle article;

  OrderItem({
    required this.id,
    required this.quantity,
    required this.articleRef,
    required this.articleLabel,
    required this.discount,
    required this.discountPercentage,
    required this.articleId,
    required this.orderId,
    required this.createdAt,
    required this.updatedAt,
    required this.unitePriceHt,
    required this.unitePriceTtc,
    required this.note,
    required this.isOutStock,
    required this.offset,
    required this.article,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      quantity: json['quantity'],
      articleRef: json['articleRef'],
      articleLabel: json['articleLabel'],
      discount: double.parse(json['discount']),
      discountPercentage: json['discountPercentage'],
      articleId: json['articleId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      orderId: json['orderId'],
      unitePriceHt: double.parse(json['unitePriceHt']),
      unitePriceTtc: double.parse(json['unitePriceTtc']),
      note: json['note'],
      isOutStock: json['isOutStock'],
      offset: json['offset'],
      article: BaseArticle.fromJson(json['article']),
    );
  }

  // OrderItem copyWith({
  //   int? orderItemId,
  //   int? quantity,
  //   String? articleRef,
  //   String? articleLabel,
  //   int? discount,
  //   int? discountPercentage,
  //   int? tvaPercentage,
  //   int? unitePriceHt,
  //   double? unitePriceTtc,
  //   String? note,
  //   bool? isOutStock,
  //   int? offset,
  //   Article? article,
  // }) =>
  //     OrderItem(
  //       orderItemId: orderItemId ?? this.orderItemId,
  //       quantity: quantity ?? this.quantity,
  //       articleRef: articleRef ?? this.articleRef,
  //       articleLabel: articleLabel ?? this.articleLabel,
  //       discount: discount ?? this.discount,
  //       discountPercentage: discountPercentage ?? this.discountPercentage,
  //       tvaPercentage: tvaPercentage ?? this.tvaPercentage,
  //       unitePriceHt: unitePriceHt ?? this.unitePriceHt,
  //       unitePriceTtc: unitePriceTtc ?? this.unitePriceTtc,
  //       note: note ?? this.note,
  //       isOutStock: isOutStock ?? this.isOutStock,
  //       offset: offset ?? this.offset,
  //       article: article ?? this.article,
  //     );
}
