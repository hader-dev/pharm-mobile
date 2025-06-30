import 'package:equatable/equatable.dart';

class BaseCompany with EquatableMixin {
  final String id;
  final dynamic thumbnailImage;
  final dynamic image;
  final String name;

  BaseCompany({
    required this.id,
    required this.thumbnailImage,
    required this.image,
    required this.name,
  });
  factory BaseCompany.fromJson(Map<String, dynamic> json) {
    return BaseCompany(
      id: json["id"] ?? "",
      thumbnailImage: json["thumbnailImage"],
      image: json["image"],
      name: json["name"] ?? "",
    );
  }

  @override
  List<Object?> get props => [
        id,
      ];
}

class Company extends BaseCompany {
  final String? latitude;
  final String? longitude;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? managerUserId;
  final int? type;
  final dynamic distributorCategory;
  final String? address;
  final String? phone;
  final String? phone2;
  final String? fax;
  final String? email;
  final String? description;
  final String? bankAccount;
  final String? fiscalId;
  final String? rcNumber;
  final String? aiNumber;
  final String? nisNumber;
  final dynamic contactInfo;
  final bool? isActive;

  Company({
    required super.id,
    required super.thumbnailImage,
    required super.image,
    required super.name,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
    this.managerUserId,
    this.type,
    this.distributorCategory,
    this.address,
    this.phone,
    this.phone2,
    this.fax,
    this.email,
    this.description,
    this.bankAccount,
    this.fiscalId,
    this.rcNumber,
    this.aiNumber,
    this.nisNumber,
    this.contactInfo,
    this.isActive,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json["id"] ?? "",
      thumbnailImage: json["thumbnailImage"],
      image: json["image"],
      name: json["name"] ?? "",
      latitude: json["latitude"],
      longitude: json["longitude"],
      createdAt: json["createdAt"] != null ? DateTime.tryParse(json["createdAt"]) : null,
      updatedAt: json["updatedAt"] != null ? DateTime.tryParse(json["updatedAt"]) : null,
      managerUserId: json["managerUserId"],
      type: json["type"],
      distributorCategory: json["distributorCategory"],
      address: json["address"],
      phone: json["phone"],
      phone2: json["phone2"],
      fax: json["fax"],
      email: json["email"],
      description: json["description"],
      bankAccount: json["bankAccount"],
      fiscalId: json["fiscalId"],
      rcNumber: json["rcNumber"],
      aiNumber: json["aiNumber"],
      nisNumber: json["nisNumber"],
      contactInfo: json["contactInfo"],
      isActive: json["isActive"],
    );
  }
}
