import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/models/image.dart';

Company? jsonToBaseCompany(Map<String, dynamic> json) {
  Company? result;

  result = Company(
      id: json["id"],
      thumbnailImage: json["thumbnailImage"] != null
          ? ImageModel.fromJson(json["thumbnailImage"])
          : null,
      image: json["image"],
      name: json["name"]);

  return result;
}
