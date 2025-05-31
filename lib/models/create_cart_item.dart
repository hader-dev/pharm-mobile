class CreateCartItemModel {
  final int articleId;
  final int quantity;
  final int offset;
  String note;
  CreateCartItemModel({required this.articleId, required this.quantity, this.offset = 0, this.note = ''});
  Map<String, Object> toMap() => {'articleId': articleId, 'quantity': quantity, 'offset': offset, 'note': note};
}
