import 'package:hader_pharm_mobile/models/image.dart';
import 'package:hader_pharm_mobile/models/role.dart';

class UserModel {
  final String id;
  final ImageModel? image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String email;
  final String fullName;
  final dynamic phone;
  final bool isActive;
  final bool emailVerified;
  final bool phoneVerified;
  final dynamic lastLogin;
  final Role role;
  final String address;

  UserModel({
    required this.address,
    required this.role,
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

}
