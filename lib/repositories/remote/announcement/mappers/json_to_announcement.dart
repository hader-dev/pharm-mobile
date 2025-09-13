import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/models/announcement.dart';
import 'package:hader_pharm_mobile/models/image.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/response/response_load_announcement_details.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/response/response_load_announcements.dart';
import 'package:hader_pharm_mobile/repositories/remote/company/mappers/json_to_base_company.dart';
import 'package:hader_pharm_mobile/repositories/remote/medicine_catalog/mappers/json_to_medicine_catalogue_item.dart';
import 'package:hader_pharm_mobile/repositories/remote/parapharm_catalog/mappers/json_to_parapharma_catalogue_item.dart';

AnnouncementModel jsonToAnnouncement(Map<String, dynamic> json) {
  return AnnouncementModel(
    id: json["id"] ?? "unknown",
    createdAt: json["createdAt"] != null
        ? DateTime.tryParse(json["createdAt"]) ?? DateTime(1970)
        : DateTime(1970),
    updatedAt: json["updatedAt"] != null
        ? DateTime.tryParse(json["updatedAt"]) ?? DateTime(1970)
        : null,
    image: json["image"] != null ? ImageModel.fromJson(json["image"]) : null,
    title: json['title'] ?? "unknown",
    content: json['content'] ?? "unknown",
    thumbnailImage: json["thumbnailImage"] != null
        ? ImageModel.fromJson(json["thumbnailImage"])
        : null,
  );
}

List<AnnouncementModel> jsonToAnnouncementsList(List<dynamic> json) {
  return json.map((announcement) => jsonToAnnouncement(announcement)).toList();
}

ResponseLoadAnnouncements jsonToAnnouncementsResponse(
    Map<String, dynamic> json) {
  final data = json['data'];
  if (data is List) {
    final announcements =
        data.map((e) => jsonToAnnouncement(e as Map<String, dynamic>)).toList();
    return ResponseLoadAnnouncements(
        announcements: announcements, totalItems: json['totalItems'] ?? 0);
  }
  return ResponseLoadAnnouncements(announcements: []);
}

ResponseLoadAnnouncementDetails jsonToAnnouncementDetailsResponse(
    Map<String, dynamic> json) {
  final announcement = jsonToAnnouncement(json);

  final company = jsonToBaseCompany(json["company"] as Map<String, dynamic>);

  final List<MedicineCatalogModel> medicines = [];
  final List<ParaPharmaCatalogModel> parapharmas = [];

  final catalogueSource = json["announcementsCatalog"];

  for (Map<String, dynamic> item in catalogueSource) {
    final sourceMedicine = item["medicineCatalog"];
    if (sourceMedicine != null) {
      medicines.add(jsonToMedicineCatalogItem(sourceMedicine));
    }

    final sourceParapharma = item["parapharmCatalog"];
    debugPrint(sourceMedicine.toString());

    if (sourceParapharma != null) {
      parapharmas.add(jsonToParapharmaCatalogueItem(sourceParapharma));
    }
  }

  return ResponseLoadAnnouncementDetails(
      announcement: announcement,
      medicines: medicines,
      parapharmas: parapharmas,
      company: company);
}
