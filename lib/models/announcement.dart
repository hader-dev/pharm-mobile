class AnnouncementModel {
  final String imgPath;
  AnnouncementModel({required this.imgPath});
  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      imgPath: json['img_path'],
    );
  }
}
