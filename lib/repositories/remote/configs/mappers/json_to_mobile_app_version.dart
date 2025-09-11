import 'package:hader_pharm_mobile/models/mobile_app_version.dart';

MobileAppVersion jsonToMobileAppVersion(Map<String, dynamic> json) {
  return MobileAppVersion(
    url: json['url'] ?? "",
    isUpdateAvaillable: json['updateAvaillable'] ?? false,
    version: json['version'] ?? "",
  );
}
