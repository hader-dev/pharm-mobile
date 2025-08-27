class ImageModel {
  final String path;
  final String filename;
  final String mimetype;
  final int size;

  ImageModel({
    required this.path,
    required this.filename,
    required this.mimetype,
    required this.size,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        path: json["path"] ?? "",
        filename: json["filename"] ?? "",
        mimetype: json["mimetype"] ?? "",
        size: json["size"] ?? 0,
      );

}
