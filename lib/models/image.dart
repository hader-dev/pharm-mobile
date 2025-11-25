class ImageModel {
  final String path;
  final String filename;
  final String mimetype;
  final String size;

  ImageModel({
    required this.path,
    required this.filename,
    required this.mimetype,
    required this.size,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        path: json["path"] ?? "",
        filename: json["filename"] ?? "",
        mimetype: json["mimeType"] ?? "",
        size: json["size"] ?? "0",
      );

  ImageModel copyWith({
    String? path,
    String? filename,
    String? mimetype,
    String? size,
  }) {
    return ImageModel(
      path: path ?? this.path,
      filename: filename ?? this.filename,
      mimetype: mimetype ?? this.mimetype,
      size: size ?? this.size,
    );
  }

  factory ImageModel.empty() {
    return ImageModel(
      path: '',
      filename: '',
      mimetype: '',
      size: "0",
    );
  }

  factory ImageModel.mock() {
    return ImageModel(
      path: '/public/users/1/1757154776341-571378210.jpg',
      filename: 'mock_file.pdf',
      mimetype: 'application/pdf',
      size: "123456",
    );
  }
}
