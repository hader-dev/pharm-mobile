import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/models/image.dart';

Company? jsonToBaseCompany(Map<String, dynamic> json) {
  Company? result;

  result = Company(
      id: json["id"],
      thumbnailImage:
          json["image"] != null ? ImageModel.fromJson(json["image"]) : null,
      image: json["image"] != null ? ImageModel.fromJson(json["image"]) : null,
      name: json["name"]);

  return result;
}
