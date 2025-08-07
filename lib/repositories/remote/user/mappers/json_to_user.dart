

import 'package:hader_pharm_mobile/models/image.dart';
import 'package:hader_pharm_mobile/models/user.dart';
import 'package:hader_pharm_mobile/models/role.dart';

UserModel jsonToUser(Map<String, dynamic> json) {
   return UserModel(
        address: json["company"] !=null ? json["company"]["address"] ?? "" : "",
        role: Role.fromId(json["roleId"]),
        id: json["id"],
        image:
            json["image"] != null ? ImageModel.fromJson(json["image"]) : null,
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