import 'package:equatable/equatable.dart';

class BaseCompany with EquatableMixin {
  static final baseCompanyFields = ["id", "thumbnailImage", "image", "name", "address", "phone", "email"];
  final String id;
  final dynamic thumbnailImage;
  final dynamic image;
  final String name;
  final String? address;
  final String? phone;
  final String? email;
  BaseCompany({
    required this.id,
    required this.thumbnailImage,
    required this.image,
    required this.name,
    this.address,
    this.phone,
    this.email,
  });
  factory BaseCompany.fromJson(Map<String, dynamic> json) {
    return BaseCompany(
      id: json["id"] ?? "",
      thumbnailImage: json["thumbnailImage"],
      image: json["image"],
      name: json["name"] ?? "",
      address: json["address"],
      phone: json["phone"],
      email: json["email"],
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

  final String? phone2;
  final String? fax;

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
    super.address,
    super.phone,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
    this.managerUserId,
    this.type,
    this.distributorCategory,
    this.phone2,
    this.fax,
    super.email,
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
