class Gallery {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  List<GalleryItem> items;

  Gallery({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        items: (json["items"] as List).map((x) => GalleryItem.fromJson(x)).toList(),
      );
}

class GalleryItem {
  String imgPath;

  GalleryItem({
    required this.imgPath,
  });

  factory GalleryItem.fromJson(Map<String, dynamic> json) => GalleryItem(
        imgPath: json["file"]["path"],
      );
}
