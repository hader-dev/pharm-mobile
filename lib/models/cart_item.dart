import 'cartItem_article.dart';

class CartItemModel {
  final int? id;
  int quantity;
  String note;
  final int offset;
  final CartItemArticle? article;

  CartItemModel(
    this.article, {
    required this.id,
    required this.quantity,
    required this.note,
    required this.offset,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        json['article'] != null
            ? CartItemArticle.fromJson(json['article'])
            : null,
        id: json['id'],
        quantity: json['quantity'] ?? 0,
        note: json['note'] ?? '',
        offset: json['offset'] ?? 0,
      );

  Map<String, double> getTotalPrice() {
    int tvaPercentage = article!.tvaPercentage!;
    double unitHTPrice = double.parse(article!.price!);
    double unitTTCPrice = unitHTPrice * (1 + tvaPercentage / 100);
    double totalHtPrice = unitHTPrice * quantity;
    double totalTTCPrice = unitTTCPrice * quantity;
    return <String, double>{
      "totalHtPrice": totalHtPrice,
      "totalTTCPrice": totalTTCPrice
    };
  }
}
