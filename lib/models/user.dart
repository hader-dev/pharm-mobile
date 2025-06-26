import 'package:hader_pharm_mobile/models/image.dart';

class UserModel {
  final String id;
  final dynamic image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String email;
  final String fullName;
  final dynamic phone;
  final bool isActive;
  final bool emailVerified;
  final bool phoneVerified;
  final dynamic lastLogin;

  UserModel({
    required this.id,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.email,
    required this.fullName,
    required this.phone,
    required this.isActive,
    required this.emailVerified,
    required this.phoneVerified,
    required this.lastLogin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        image: json["image"] != null ? ImageModel.fromJson(json["image"]) : null,
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        email: json["email"],
        fullName: json["fullName"],
        phone: json["phone"],
        isActive: json["isActive"],
        emailVerified: json["emailVerified"],
        phoneVerified: json["phoneVerified"],
        lastLogin: json["lastLogin"],
      );
}
