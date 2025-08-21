import 'package:equatable/equatable.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';

class BaseCompany with EquatableMixin {
  static final baseCompanyFields = [
    "id",
    "thumbnailImage",
    "image",
    "name",
    "address",
    "phone",
    "email"
  ];
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
  final bool? isLiked;
  final bool? isFollowing;

  Company({
    required super.id,
    required super.thumbnailImage,
    required super.image,
    required super.name,
    super.address,
    super.phone,
    this.isFollowing,
    this.isLiked,
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

  factory Company.empty() {
    return Company(
      id: '',
      thumbnailImage: '',
      image: '',
      name: '',
      address: null,
      phone: null,
      latitude: null,
      longitude: null,
      createdAt: null,
      updatedAt: null,
      managerUserId: null,
      type: null,
      distributorCategory: null,
      phone2: null,
      fax: null,
      email: null,
      description: null,
      bankAccount: null,
      fiscalId: null,
      rcNumber: null,
      aiNumber: null,
      nisNumber: null,
      contactInfo: null,
      isActive: null,
    );
  }

  String? get thumbnailImageUrl => thumbnailImage is String
      ? thumbnailImage as String
      : "${getItInstance<INetworkService>().baseUrl}/files/$thumbnailImage";
}
