import 'package:hader_pharm_mobile/models/image.dart';

class PdfDocument {
  final String path;
  final String filename;
  final String mimetype;
  final String size;

  PdfDocument({
    required this.path,
    required this.filename,
    required this.mimetype,
    required this.size,
  });

  factory PdfDocument.fromJson(Map<String, dynamic> json) {
    return PdfDocument(
      path: json['path'] ?? '',
      filename: json['filename'] ?? '',
      mimetype: json['mimetype'] ?? '',
      size: json['size'] ?? "0",
    );
  }
}

class AnnouncementModel {
  final String id;
  final ImageModel? image;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final ImageModel? thumbnailImage;
  final PdfDocument? pdf;

  AnnouncementModel({
    required this.id,
    required this.createdAt,
    this.updatedAt,
    required this.title,
    required this.content,
    this.image,
    this.thumbnailImage,
    this.pdf,
  });

  factory AnnouncementModel.empty() {
    return AnnouncementModel(
      id: "",
      createdAt: DateTime(1970),
      updatedAt: null,
      title: "",
      content: "",
      image: null,
      thumbnailImage: null,
      pdf: null,
    );
  }
}
