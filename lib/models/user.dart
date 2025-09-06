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
    required this.role,
    required this.address,
  });

  factory UserModel.empty() {
    return UserModel(
      id: '',
      image: null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
      email: '',
      fullName: '',
      phone: null,
      isActive: false,
      emailVerified: false,
      phoneVerified: false,
      lastLogin: null,
      role: Role.guest(),
      address: '',
    );
  }

  factory UserModel.mock() {
    return UserModel(
      id: 'user_123',
      image: ImageModel.mock(),
      createdAt: DateTime.now().subtract(Duration(days: 200)),
      updatedAt: DateTime.now(),
      email: 'johndoe@example.com',
      fullName: 'John Doe',
      phone: '+1234567890',
      isActive: true,
      emailVerified: true,
      phoneVerified: true,
      lastLogin: DateTime.now().subtract(Duration(days: 1)),
      role: Role.pharmacyManager(),
      address: '123 Main St, Testville',
    );
  }
}
