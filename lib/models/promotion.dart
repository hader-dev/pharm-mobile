class PromotionModel {
  final String imgPath;
  PromotionModel({required this.imgPath});
  factory PromotionModel.fromJson(Map<String, dynamic> json) {
    return PromotionModel(
      imgPath: json['img_path'],
    );
  }
}
