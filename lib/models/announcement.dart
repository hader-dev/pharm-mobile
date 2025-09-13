import 'package:hader_pharm_mobile/models/image.dart';

class AnnouncementModel {
  final String id;
  final ImageModel? image;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final ImageModel? thumbnailImage;
  AnnouncementModel({
    required this.id,
    required this.createdAt,
    this.updatedAt,
    required this.title,
    required this.content,
    this.image,
    this.thumbnailImage,
  });
}
