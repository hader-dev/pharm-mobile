import 'client.dart';

class UserModel {
  final int userId;
  final String username;
  final int roleId;
  final ClientModel? client;

  UserModel({
    required this.userId,
    required this.username,
    required this.roleId,
    this.client,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['id'],
      username: json['username'],
      roleId: json['roleId'],
      client: json['client'] == null ? null : ClientModel.fromJson(json['client']),
    );
  }
}
