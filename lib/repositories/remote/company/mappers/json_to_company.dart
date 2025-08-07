import 'package:hader_pharm_mobile/models/company.dart';

Company? jsonToCompany(Map<String, dynamic> json) {
  Company? result;

  result = Company(
      id: json["id"],
      thumbnailImage: json["thumbnailImage"],
      image: json["image"],
      name: json["name"]);

  return result;
}
