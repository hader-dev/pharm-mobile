import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/models/image.dart';

Company jsonToCompany(Map<String, dynamic> json) {
  return Company(
    id: json["id"] ?? "",
    thumbnailImage: json["thumbnailImage"] != null
        ? ImageModel.fromJson(json["thumbnailImage"])
        : null,
    image: json["image"] != null ? ImageModel.fromJson(json["image"]) : null,
    name: json["name"] ?? "",
    latitude: json["latitude"],
    longitude: json["longitude"],
    createdAt:
        json["createdAt"] != null ? DateTime.tryParse(json["createdAt"]) : null,
    updatedAt:
        json["updatedAt"] != null ? DateTime.tryParse(json["updatedAt"]) : null,
    managerUserId: json["managerUserId"],
    type: json["type"],
    distributorCategory: json["distributorCategory"],
    address: json["address"],
    phone: json["phone"],
    phone2: json["phone2"],
    fax: json["fax"],
    website: json["website"],
    email: json["email"],
    description: json["description"],
    bankAccount: json["bankAccount"],
    fiscalId: json["fiscalId"],
    rcNumber: json["rcNumber"],
    aiNumber: json["aiNumber"],
    nisNumber: json["nisNumber"],
    contactInfo: json["contactInfo"],
    isActive: json["isActive"],
    isLiked: json["isLiked"] ?? false,
  );
}
