import 'package:equatable/equatable.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/image.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';

class BaseCompany with EquatableMixin {
  static final baseCompanyFields = ["id", "name", "address", "phone", "email"];
  final String id;
  final ImageModel? thumbnailImage;
  final ImageModel? image;
  final String name;
  final String? address;
  final String? phone;
  final String? email;
  const BaseCompany({
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
      thumbnailImage:
          json["image"] != null ? ImageModel.fromJson(json["image"]) : null,
      image: json["image"] != null ? ImageModel.fromJson(json["image"]) : null,
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
  final String? website;

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

  final String? willaya;
  final String? town;
  final String? regionId;

  const Company({
    required super.id,
    required super.thumbnailImage,
    required super.image,
    required super.name,
    super.address,
    super.phone,
    this.willaya,
    this.town,
    this.regionId,
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
    this.website,
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
      thumbnailImage: null,
      image: null,
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
      website: null,
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

  factory Company.mock() {
    return Company(
      id: 'cmp_001',
      thumbnailImage: ImageModel.mock(),
      image: ImageModel.mock(),
      name: 'Mock Company',
      address: '123 Mock St, Test City',
      phone: '+1234567890',
      latitude: "36.75",
      longitude: "3.04",
      createdAt: DateTime.now().subtract(Duration(days: 100)),
      updatedAt: DateTime.now(),
      managerUserId: 'user_001',
      type: CompanyType.distributor.id,
      distributorCategory: DistributorCategory.both,
      phone2: '+1234567891',
      fax: '+1234567892',
      website: 'https://mockcompany.test',
      email: 'info@mockcompany.test',
      description: 'This is a mock company used for testing.',
      bankAccount: 'DE89 3704 0044 0532 0130 00',
      fiscalId: 'FISC123456',
      rcNumber: 'RC789456',
      aiNumber: 'AI987654',
      nisNumber: 'NIS654321',
      contactInfo: 'John Doe - Manager',
      isActive: true,
    );
  }

  static const placeholder = Company(
    id: '',
    thumbnailImage: null,
    image: null,
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
    website: null,
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

  String? get thumbnailImageUrl => thumbnailImage is String
      ? thumbnailImage as String
      : "${getItInstance<INetworkService>().baseUrl}/files/$thumbnailImage";
}
