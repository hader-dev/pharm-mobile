import 'package:hader_pharm_mobile/models/medicine.dart';

Medicine jsonToMedicine(Map<String, dynamic> json) {
  return Medicine(
    image: json["image"],
    registrationNumber: json["registrationNumber"] ?? "",
    code: json["code"] ?? "",
    dci: json["dci"] ?? "",
    brandName: json["brandName"] ?? "",
    form: json["form"] ?? "",
    dosage: json["dosage"] ?? "",
    packaging: json["packaging"] ?? "",
    list: json["list"] ?? "",
    p1: json["p1"] ?? "",
    p2: json["p2"] ?? "",
    obs: json["obs"],
    laboratoryHolder: json["laboratoryHolder"] ?? "",
    laboratoryCountry: json["laboratoryCountry"] ?? "",
    initialRegistrationDate: json["initialRegistrationDate"] != null
        ? DateTime.tryParse(json["initialRegistrationDate"])
        : null,
    finalRegistrationDate: json["finalRegistrationDate"] != null
        ? DateTime.tryParse(json["finalRegistrationDate"])
        : null,
    type: json["type"] ?? "",
    status: json["status"] ?? "",
    lifeTime: json["lifeTime"] ?? "",
    isActive: json["isActive"] ?? false,
  );
}
