import 'package:hader_pharm_mobile/utils/enums.dart';

class ParamsCreateClient {
  final String email;
  final String name;
  final String address;
  final String phone;
  final String fullName;
  final int townId;
  final CompanyType companyType;

  ParamsCreateClient({
    required this.email,
    required this.name,
    required this.address,
    required this.phone,
    required this.companyType,
    required this.fullName,
    required this.townId,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "name": name,
      "address": address.isNotEmpty ? address : null,
      "phone": phone.isNotEmpty ? phone : null,
      "fullName": fullName,
      "townId": townId,
      "type": companyType.id
    };
  }
}
